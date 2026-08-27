return {
    {
        "nvim-lualine/lualine.nvim",

        config = function()
            local grey = "#7e7e7f"
            local text = "#e0e0e0"

            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    section_separators = "",
                    component_separators = " | ",
                    globalstatus = true,
                    theme = {
                        normal = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                        insert = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                        visual = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                        replace = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                        command = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                        inactive = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                        },
                    },
                },

                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })

            -- FORCE lualine to stay grey
            vim.api.nvim_set_hl(0, "StatusLine", {
                fg = text,
                bg = grey,
            })

            vim.api.nvim_set_hl(0, "StatusLineNC", {
                fg = text,
                bg = grey,
            })
        end,
    },
}
