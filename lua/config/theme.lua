local M = {}

local STATE_DIR = vim.fn.expand("~/.local/state/omarchy/current")
local USER_THEMES = vim.fn.expand("~/.config/omarchy/themes")
local STOCK_THEMES = "/usr/share/omarchy/themes"

local legacy_map = {
  aether = "aether",
  catppuccin = "catppuccin",
  ["catppuccin-latte"] = "catppuccin",
  ["tokyo-night"] = "tokyonight",
  gruvbox = "gruvbox",
  nord = "nightfox",
  ["rose-pine"] = "rose-pine",
  everforest = "everforest",
  kanagawa = "kanagawa",
  ["flexoki-light"] = "flexoki",
  ["osaka-jade"] = "bamboo",
  hackerman = "hackerman",
  ["retro-82"] = "retro-82",
  miasma = "gruvbox",
  lumon = "lumon",
  ["matte-black"] = "matteblack",
  ristretto = "gruvbox",
  ethereal = "tokyonight",
  ["last-horizon"] = "tokyonight-night",
  lupine = "catppuccin",
  solitude = "ashen",
  vantablack = "gruvbox",
  white = "catppuccin",
}

local cache = {}

local function read_file(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

function M.get_theme_name()
  local name = read_file(STATE_DIR .. "/theme.name")
  if not name then return nil end
  name = name:gsub("%s+", ""):gsub("%s", "-")
  if name == "" then return nil end
  return name
end

function M.get_theme_mode()
  for _, path in ipairs({
    STATE_DIR .. "/theme/colors.toml",
    USER_THEMES .. "/" .. (M.get_theme_name() or "") .. "/colors.toml",
  }) do
    local content = read_file(path)
    if content then
      local mode = content:match('mode%s*=%s*"([^"]+)"')
      if mode == "light" or mode == "dark" then return mode end
    end
  end
  return "dark"
end

local function locate_neovim_lua(slug)
  for _, path in ipairs({
    USER_THEMES .. "/" .. slug .. "/neovim.lua",
    STOCK_THEMES .. "/" .. slug .. "/neovim.lua",
  }) do
    if vim.uv.fs_stat(path) then return path end
  end
  return nil
end

M.paths = { state = STATE_DIR, user = USER_THEMES, stock = STOCK_THEMES }

local function normalize(ret)
  if type(ret) ~= "table" then return {} end
  if type(ret[1]) == "table" then
    local specs = {}
    for _, s in ipairs(ret) do
      if type(s) == "table" and type(s[1]) ~= "table" then specs[#specs + 1] = s end
    end
    return specs
  elseif type(ret[1]) == "string" then
    for k in pairs(ret) do
      if type(k) ~= "number" then return { ret } end
    end
    local specs = {}
    for _, s in ipairs(ret) do
      if type(s) == "string" then specs[#specs + 1] = { s } end
    end
    return specs
  end
  return { ret }
end

local function is_repo(value)
  return type(value) == "string"
    and value:match("^[%w%-%_%%.]+/[%w%-%_%%.]+$") ~= nil
    and #value <= 100
end

local function resolve_specs(specs)
  local result = {
    specs = {},
    colorscheme = nil,
    background = nil,
  }
  for _, frag in ipairs(specs) do
    local repo = frag[1]
    if repo == "LazyVim/LazyVim" then
      local opts = frag.opts or {}
      result.colorscheme = opts.colorscheme or result.colorscheme
      result.background = opts.background or result.background
    elseif is_repo(repo) then
      result.specs[#result.specs + 1] = frag
    end
  end
  return result
end

function M.resolve(slug)
  slug = slug or M.get_theme_name()
  if not slug then
    return { found = false, specs = {}, colorscheme = "gruvbox", background = nil }
  end

  local cached = cache[slug]
  if cached then return cached end

  local path = locate_neovim_lua(slug)
  local resolved
  if path then
    local chunk = loadfile(path)
    local ok, ret = pcall(chunk)
    if ok then
      resolved = resolve_specs(normalize(ret))
      resolved.found = true
    else
      vim.notify("omarchy theme: failed to load " .. path .. ": " .. tostring(ret), vim.log.levels.WARN)
      resolved = { found = true, specs = {}, colorscheme = nil, background = nil }
    end
  else
    resolved = {
      found = false,
      specs = {},
      colorscheme = legacy_map[slug],
      background = nil,
    }
  end

  if not resolved.colorscheme and not resolved.found then
    resolved.colorscheme = "gruvbox"
  end

  cache[slug] = resolved
  return resolved
end

function M.resolve_current()
  return M.resolve(M.get_theme_name())
end

local function eagerize(spec)
  if spec.lazy == nil and spec.event == nil and spec.cmd == nil and spec.keys == nil and spec.ft == nil then
    spec.lazy = false
  end
  spec.priority = spec.priority or 1000
  return spec
end

M.eagerize = eagerize

local function set_background(mode_hint, background_hint)
  if background_hint == "soft" or background_hint == "medium" or background_hint == "hard" then
    vim.g.everforest_background = background_hint
    vim.o.background = "dark"
    return
  end
  local mode = (mode_hint == "light" or mode_hint == "dark") and mode_hint
    or ((background_hint == "light" or background_hint == "dark") and background_hint)
    or M.get_theme_mode()
  vim.o.background = mode
end

local function load_plugin(spec)
  local name = spec[1]
  local ok, registry = pcall(function() return require("lazy.core.config").plugins end)
  if ok and registry and registry[name] then
    pcall(require("lazy").load, { plugins = { name } })
    return
  end
  local data = vim.fn.stdpath("data") .. "/lazy/"
  local candidates = {}
  if spec.name then candidates[#candidates + 1] = spec.name end
  candidates[#candidates + 1] = name:match("([^/]+)$")
  local dir
  for _, candidate in ipairs(candidates) do
    if candidate and vim.uv.fs_stat(data .. candidate) then
      dir = data .. candidate
      break
    end
  end
  if not dir then
    vim.notify("omarchy theme: plugin not installed: " .. name, vim.log.levels.WARN)
    return
  end
  vim.opt.rtp:prepend(dir)
  if type(spec.config) == "function" then
    pcall(spec.config, spec, spec.opts or {})
  elseif type(spec.opts) == "table" and spec.main then
    pcall(function()
      local mod = require(spec.main)
      if mod.setup then mod.setup(spec.opts) end
    end)
  end
end

function M.apply(slug, mode_hint)
  local resolved = M.resolve(slug)

  pcall(vim.api.nvim_del_augroup_by_name, "Omacarchy")

  for _, spec in ipairs(resolved.specs) do
    load_plugin(eagerize(vim.deepcopy(spec)))
  end

  set_background(mode_hint, resolved.background)

  local cs = resolved.colorscheme
  if type(cs) == "function" then
    local ok, err = pcall(cs)
    if not ok then
      vim.notify("omarchy theme: colorscheme function failed: " .. tostring(err), vim.log.levels.WARN)
    end
  elseif type(cs) == "string" then
    pcall(vim.cmd.colorscheme, cs)
  end
end

M.apply_current = function(mode_hint)
  M.apply(M.get_theme_name(), mode_hint)
end

local signal_file = STATE_DIR .. "/neovim-theme-signal"
local last_signal = read_file(signal_file)
last_signal = last_signal and last_signal:gsub("%s+", "") or ""

function M.watch()
  local timer = vim.uv.new_timer()
  if not timer then return end
  timer:start(2000, 2000, vim.schedule_wrap(function()
    local data = read_file(signal_file)
    if not data then return end
    data = data:gsub("%s+", "")
    if data == "" or data == last_signal then return end
    last_signal = data
    local slug, mode = data:match("^(.+)|(.+)$")
    if slug then
      M.apply(slug, mode)
    end
  end))
end

return M
