return {
    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    html = { "prettier" },
                    css = { "prettier" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    markdown = { "prettier" },
                },

                formatters = {
                    prettier = {
                        prepend_args = {
                            "--tab-width",
                            "4",
                        },
                    },
                },

                format_on_save = false,
            })

            vim.keymap.set("n", "<leader>fm", function()
                require("conform").format({
                    lsp_fallback = true,
                })
            end, { desc = "Format file" })
        end,
    },
}
