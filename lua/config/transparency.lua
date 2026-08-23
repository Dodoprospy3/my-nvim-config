local M = {}

local groups = {
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "SignColumn",
  "LineNr",
  "CursorLineNr",
  "FoldColumn",
  "WinSeparator",
  "FloatBorder",
}

function M.apply()
  for _, name in ipairs(groups) do
    vim.api.nvim_set_hl(0, name, { bg = "none" })
  end
end

vim.api.nvim_create_augroup("TransparentBackground", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group = "TransparentBackground",
  callback = function()
    M.apply()
  end,
})

M.apply()

return M
