return {
    {
        "nvim-lualine/lualine.nvim",

        event = "VeryLazy",

        config = function()
            local grey = "#494949"
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
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
                        },

                        insert = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
                        },

                        visual = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
                        },

                        replace = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
                        },

                        command = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
                        },

                        inactive = {
                            a = { fg = text, bg = grey },
                            b = { fg = text, bg = grey },
                            c = { fg = text, bg = grey },
                            x = { fg = text, bg = grey },
                            y = { fg = text, bg = grey },
                            z = { fg = text, bg = grey },
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
        end,
    },
}
