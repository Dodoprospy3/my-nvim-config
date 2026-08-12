return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                transparent_mode = false, -- set to false if you want Gruvbox's background
            })

            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")

            vim.api.nvim_set_hl(0, "CursorLine", {
                bg = "#3c3836",
            })
        end,
    },
}
