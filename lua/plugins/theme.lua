local theme = require("config.theme")

local function read(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

local resolved = theme.resolve_current()

local specs = {}
local seen = {}

for _, spec in ipairs(resolved.specs) do
  local repo = spec[1]
  if type(repo) == "string" then
    seen[repo] = true
    specs[#specs + 1] = theme.eagerize(spec)
  end
end

for _, base in ipairs({ theme.paths.user, theme.paths.stock }) do
  local fd = vim.uv.fs_opendir(base)
  if fd then
    while true do
      local entries = vim.uv.fs_readdir(fd)
      if not entries then break end
      table.sort(entries, function(a, b) return a.name < b.name end)
      for _, entry in ipairs(entries) do
        if entry.type == "directory" then
          local text = read(base .. "/" .. entry.name .. "/neovim.lua")
          if text then
            for repo in text:gmatch('["\']([%w%.%-_]+/[%w%.%-_]+)["\']') do
              if repo ~= "LazyVim/LazyVim" and not seen[repo] then
                seen[repo] = true
                specs[#specs + 1] = { repo, lazy = true }
              end
            end
          end
        end
      end
    end
    vim.uv.fs_closedir(fd)
  end
end

if not seen["ellisonleao/gruvbox.nvim"] then
  specs[#specs + 1] = { "ellisonleao/gruvbox.nvim", lazy = true }
end

if not seen["rose-pine/neovim"] then
  specs[#specs + 1] = { "rose-pine/neovim", lazy = true, name = "rose-pine" }
end

return specs
