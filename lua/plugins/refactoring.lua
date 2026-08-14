return {
    "ThePrimeagen/refactoring.nvim",

    dependencies = {
        "lewis6991/async.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    opts = {},

    keys = {
        {
            "<leader>rr",
            function()
                require("refactoring").select_refactor()
            end,
            mode = { "n", "x" },
            desc = "Refactoring menu",
        },
    },
}
