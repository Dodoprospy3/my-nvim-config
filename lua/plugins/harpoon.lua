return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local harpoon = require("harpoon")

        -- Required Harpoon 2 setup
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        -- Add current file
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, {
            desc = "Harpoon: Add file",
        })

        -- Open Harpoon menu
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, {
            desc = "Harpoon: Menu",
        })

        -- Select Harpoon files
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, {
            desc = "Harpoon: File 1",
        })

        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, {
            desc = "Harpoon: File 2",
        })

        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, {
            desc = "Harpoon: File 3",
        })

        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, {
            desc = "Harpoon: File 4",
        })

        -- Previous / next Harpoon file
        vim.keymap.set("n", "<leader>[", function()
            harpoon:list():prev()
        end, {
            desc = "Harpoon: Previous",
        })

        vim.keymap.set("n", "<leader>]", function()
            harpoon:list():next()
        end, {
            desc = "Harpoon: Next",
        })

        -- Remove current file from Harpoon
        vim.keymap.set("n", "<leader>d", function()
            harpoon:list():remove()
        end, {
            desc = "Harpoon: Remove file",
        })
    end,
}
