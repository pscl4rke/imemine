
vim.wo.signcolumn = "yes"
require("gitsigns").setup {
    numhl = true,
    linehl = true,
}

-- Brackets originally jump sentences; turns out I never use them
--  (use "z." afterwards to scroll to centre of screen, doesn't always work!)
vim.keymap.set("n", "(", "<cmd>Gitsigns prev_hunk<enter>z.")
vim.keymap.set("n", ")", "<cmd>Gitsigns next_hunk<enter>z.")
-- Not understood by older versions of gitsigns...
--vim.keymap.set("n", "(", "<cmd>Gitsigns nav_hunk prev<enter>")
--vim.keymap.set("n", ")", "<cmd>Gitsigns nav_hunk next<enter>")
