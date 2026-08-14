return {
    "tpope/vim-fugitive",
    cmd = {
        "Git",
        "G",
        "Gdiffsplit",
        "Gvdiffsplit",
        "Gblame",
        "Gwrite",
        "Gread",
    },
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {
            desc = "Git status",
        })

        vim.keymap.set("n", "<leader>gb", vim.cmd.Gblame, {
            desc = "Git blame",
        })
    end,
}
