
-- As per vorpal 24.04

-- This is using the `nvim_setup.vA.sh` script, which wraps around
-- my own `git ensure-repo` to give maximum ability to specify versions.

-- Configuration shared with normal vim
vim.cmd "source ~/imemine/vim/common.vim"

-- Layout
vim.o.wildmode = "longest,list"
vim.wo.number = true
vim.wo.numberwidth = 4

-- Sensible defaults for many files
--  Is this not the sort of thing LSP could override???
--  And perhaps the sort of thing EditorConfig would look after
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Editorconfig <https://editorconfig.org>
--  (actually .editorconfig files enabled by default in nvim v0.9)
--vim.g.editorconfig = true

vim.keymap.set("n", "g]", vim.lsp.buf.definition)
vim.keymap.set("n", "g[", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
-- some places have "gp" set to integrate :term with a password vault

-- Language Integration
--  Use :LspInfo and ~/.cache/nvim/lsp.log to help debugging
require("lspconfig").pylsp.setup {} -- Remember: influenced by ~/.config/pycodestyle
require("lspconfig").ts_ls.setup {}  -- use "// @ts-check" in .js/.mjs files
require("lspconfig").bashls.setup {}
require("lspconfig").gopls.setup {}
--require("lspconfig").rust_analyzer.setup {}
require("lspconfig").svelte.setup {}

require("myconf.buffertabs")
require("myconf.toggleterm")
require("myconf.gitsigns")
require("myconf.completion")
require("myconf.colours")
require("myconf.statusbar")
require("myconf.quickfix")

-- https://github.com/leafOfTree/vim-svelte-plugin
vim.cmd "let g:vim_svelte_plugin_use_typescript = 1"

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions

-- Note:
--  :checkhealth is useful
