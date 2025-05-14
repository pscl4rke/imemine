
-- As per lithium again


-- This is using the `nvim_setup.v9.sh` script, which wraps around
-- my own `git ensure-repo` to give maximum ability to specify versions.

-- Configuration shared with normal vim
vim.cmd "source ~/imemine/vim/common.vim"

-- Layout
vim.o.wildmode = "longest,list"
vim.wo.number = true
vim.wo.numberwidth = 4
vim.o.scrolloff = 3
vim.o.title = true

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

--vim.keymap.set("n", "<C-L>", "<cmd>nohl<enter><C-L>") -- default

vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
vim.keymap.set("n", "g/", function()
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query) -- shortcut for vim.api.nvim_command
end)
vim.keymap.set("n", "g]", vim.lsp.buf.definition)
vim.keymap.set("n", "g[", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
-- some places have "gp" set to integrate :term with a password vault

require("bufferline").setup {
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
    }
}

-- Language Integration
--  Use :LspInfo and ~/.cache/nvim/lsp.log to help debugging
require("lspconfig").pylsp.setup {} -- Remember: influenced by ~/.config/pycodestyle
--require("lspconfig").tsserver.setup {}  -- use "// @ts-check" in .js/.mjs files
-- error msg: tsserver is deprecated, use ts_ls instead
require("lspconfig").bashls.setup {}
require("lspconfig").gopls.setup {}
--require("lspconfig").rust_analyzer.setup {}

require("myconf.toggleterm")
require("myconf.gitsigns")
require("myconf.completion")
require("myconf.colours")
require("myconf.statusbar")
require("myconf.quickfix")

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions

-- Note:
--  :checkhealth is useful
