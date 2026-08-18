return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        -- Add/remove current file
        vim.keymap.set("n", "<leader>a", function()
            local list = harpoon:list()
            local current_file = vim.api.nvim_buf_get_name(0)

            for i, item in ipairs(list.items) do
                if item.value == current_file then
                    list:remove_at(i)
                    return
                end
            end

            list:add()
        end, { desc = "Harpoon: Toggle file" })

        -- Open Harpoon menu
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: Menu" })

        -- Select files
        vim.keymap.set("n", "<C-1>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: File 1" })

        vim.keymap.set("n", "<C-2>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: File 2" })

        vim.keymap.set("n", "<C-3>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: File 3" })

        vim.keymap.set("n", "<C-4>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: File 4" })
    end,
}
