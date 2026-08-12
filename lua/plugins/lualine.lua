return {
    {
        "nvim-lualine/lualine.nvim",

        config = function()
            local mono_theme = {
                normal = {
                    a = { fg = "#e0e0e0", bg = "#303030" },
                    b = { fg = "#e0e0e0", bg = "#303030" },
                    c = { fg = "#e0e0e0", bg = "#303030" },
                },

                insert = {
                    a = { fg = "#e0e0e0", bg = "#303030" },
                    b = { fg = "#e0e0e0", bg = "#303030" },
                    c = { fg = "#e0e0e0", bg = "#303030" },
                },

                visual = {
                    a = { fg = "#e0e0e0", bg = "#303030" },
                    b = { fg = "#e0e0e0", bg = "#303030" },
                    c = { fg = "#e0e0e0", bg = "#303030" },
                },

                replace = {
                    a = { fg = "#e0e0e0", bg = "#303030" },
                    b = { fg = "#e0e0e0", bg = "#303030" },
                    c = { fg = "#e0e0e0", bg = "#303030" },
                },

                inactive = {
                    a = { fg = "#e0e0e0", bg = "#303030" },
                    b = { fg = "#e0e0e0", bg = "#303030" },
                    c = { fg = "#e0e0e0", bg = "#303030" },
                },
            }

            require("lualine").setup({
                options = {
                    theme = mono_theme,

                    icons_enabled = false,

                    section_separators = "",
                    component_separators = " | ",

                    globalstatus = true,
                },

                sections = {
                    lualine_a = {
                        "mode",
                    },

                    lualine_b = {
                        "branch",
                    },

                    lualine_c = {
                        "filename",
                    },

                    lualine_x = {
                        "filetype",
                    },

                    lualine_y = {
                        "progress",
                    },

                    lualine_z = {
                        "location",
                    },
                },
            })
        end,
    },
}
