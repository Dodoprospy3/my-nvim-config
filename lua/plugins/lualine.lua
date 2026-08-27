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
                    lualine_a = {
                        {
                            "mode",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },

                    lualine_b = {
                        {
                            "branch",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },

                    lualine_c = {
                        {
                            "filename",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },

                    lualine_x = {
                        {
                            "filetype",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },

                    lualine_y = {
                        {
                            "progress",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },

                    lualine_z = {
                        {
                            "location",
                            color = {
                                fg = text,
                                bg = grey,
                            },
                        },
                    },
                },
            })
        end,
    },
}
