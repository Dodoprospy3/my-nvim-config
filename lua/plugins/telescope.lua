return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",

        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    prompt_prefix = "> ",
                    selection_caret = "> ",
                    entry_prefix = "  ",

                    -- TTY friendly
                    color_devicons = false,

                    -- Avoid Treesitter preview crashes
                    preview = {
                        treesitter = false,
                    },

                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close,
                        },
                    },
                },

                pickers = {
                    find_files = {
                        hidden = true,
                        disable_devicons = true,
                    },

                    live_grep = {
                        disable_devicons = true,
                    },

                    buffers = {
                        disable_devicons = true,
                    },

                    git_files = {
                        disable_devicons = true,
                    },
                },
            })

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {
                desc = "Find Files",
            })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
                desc = "Live Grep",
            })

            vim.keymap.set("n", "<leader>fb", builtin.buffers, {
                desc = "Find Buffers",
            })
        end,
    },
}
