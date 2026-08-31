return {
    {
        "williamboman/mason.nvim",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },

        config = function()
            vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Python
                    "basedpyright",

                    -- Lua
                    "lua_ls",

                    -- Go
                    "gopls",

                    -- Rust
                    "rust_analyzer",

                    -- C
                    "clangd",

                    -- JavaScript / TypeScript
                    "ts_ls",

                    -- Web
                    "html",
                    "cssls",
                    "emmet_ls",

                    -- JSON / JSONC
                    "jsonls",

                    -- Config files
                    "bashls",
                    "yamlls",
                },
            })

            vim.lsp.config("ts_ls", {
                root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
            })

            vim.lsp.config("emmet_ls", {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescriptreact",
                },
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },
                    },
                },
            })

            vim.lsp.enable({
                -- Python
                "basedpyright",

                -- Lua
                "lua_ls",

                -- Go
                "gopls",

                -- Rust
                "rust_analyzer",

                -- C
                "clangd",

                -- JavaScript / TypeScript
                "ts_ls",

                -- HTML / CSS
                "html",
                "cssls",
                "emmet_ls",

                -- JSON / JSONC
                "jsonls",

                -- Config files
                "bashls",
                "yamlls",
            })
        end,
    },
}
