return {
    {
        "stevearc/oil.nvim",

        config = function()
            local oil = require("oil")

            oil.setup({
                default_file_explorer = true,

                columns = {},

                view_options = {
                    show_hidden = true,
                },

                keymaps = {
                    ["-"] = false,
                },
            })

            vim.keymap.set("n", "-", function()
                if vim.bo.filetype == "oil" then
                    oil.close()
                else
                    oil.open()
                end
            end, {
                desc = "Toggle Oil",
                silent = true,
            })
        end,
    },
}
