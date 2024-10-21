
-- As per pendennis

-- A future alternative might be to use paq.nvim rather than packer

-- $ mkdir -p ~/.local/share/nvim/site/pack/packer/start/
-- $ git clone https://github.com/wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- :PackerInstall or :PackerSync

require("packer").startup(function(use)

    -- Packer can manage itself after the initial bootstrapping:
    use {"https://github.com/wbthomason/packer.nvim"}

    -- Command Integration
    use {"https://github.com/akinsho/toggleterm.nvim"}

    -- Codebase Integration
    use {"https://github.com/lewis6991/gitsigns.nvim", tag = "v0.6"}
    use {"https://github.com/editorconfig/editorconfig-vim"}

    -- Opening
    use {"https://github.com/junegunn/fzf", tag = "0.24.0"}
    --use {"https://github.com/junegunn/fzf.vim.git"}  -- :Lines, :BLines
    use {"https://github.com/jremmen/vim-ripgrep"}

    -- Language Integration
    use {"https://github.com/neovim/nvim-lspconfig.git"}

    -- Completion
    use {"https://github.com/hrsh7th/nvim-cmp.git"}
    use {"https://github.com/hrsh7th/cmp-buffer.git"}
    use {"https://github.com/hrsh7th/cmp-path.git"}
    use {"https://github.com/hrsh7th/cmp-nvim-lsp.git"}

    -- Use Buffers Like Tabs
    use {"https://github.com/akinsho/bufferline.nvim"}
    use {"https://github.com/nvim-lualine/lualine.nvim"}

end)

-- Configuration shared with normal vim
vim.cmd "source ~/imemine/vim/common.vim"

-- Layout
vim.wo.number = true
vim.wo.numberwidth = 4
vim.o.scrolloff = 3
vim.o.title = true

-- Here's looking at you HTML...
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Command
require("toggleterm").setup {
    open_mapping = [[<C-\>]],
    direction = "float",
}

-- VCS
--  FIXME colour backgrounds
vim.wo.signcolumn = "yes"
require("gitsigns").setup {
    numhl = true,
    linehl = true,
}

-- Indentation
--  Naive (copy previous line) on, but fancy stuff kept over-indenting
--  especially in HTML and JS
--  Maybe turn it on again for specific languages
vim.o.autoindent = true
vim.cmd("filetype plugin indent off")
vim.cmd("filetype indent off")
--vim.cmd("autocmd FileType html filetype plugin indent off")
--vim.cmd("autocmd FileType htmldjango filetype plugin indent off")
--vim.cmd("autocmd FileType html filetype off")
--vim.cmd("autocmd FileType htmldjango filetype off")
--vim.cmd("filetype plugin on")
--vim.cmd("autocmd BufRead,BufNewFile * filetype indent on")
--vim.cmd("autocmd BufRead,BufNewFile *.html filetype indent off")
--vim.o.autoindent = false
vim.cmd("autocmd BufRead,BufNewFile *.py filetype indent on")

vim.keymap.set("n", "gO", "<cmd>edit .<enter>")  -- NetRW or equiv
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")
vim.keymap.set("n", "ZQ", "<cmd>bdelete<enter>")  -- should this autodiscard (no save)?
vim.keymap.set("n", "g]", vim.lsp.buf.definition)
vim.keymap.set("n", "g[", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "ca", vim.lsp.buf.rename) -- [c]hange [a]ll
-- tried but they do nothing (in python at least!)...
--  :lua vim.lsp.buf.incoming_calls()
--  :lua vim.lsp.buf.outgoing_calls()
-- still to try...
--  :lua vim.lsp.buf.format()
--  :lua vim.lsp.buf.code_action()

require("bufferline").setup {
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
        show_buffer_close_icons = false,
        tab_size = 8,
        max_name_length = 10,
    }
}

-- Quickfix
function table_contains(tbl, x) -- euugh... surely lua has a built-in?!?!
    found = false
    for _, v in pairs(tbl) do
        if v == x then 
            found = true 
        end
    end
    return found
end
if table_contains(vim.v.argv, "-q") then
    vim.cmd("copen")
end

-- Language Integration
--  Use :LspInfo and ~/.cache/nvim/lsp.log to help debugging
require("lspconfig").pylsp.setup {} -- Remember: influenced by ~/.config/pycodestyle
require("lspconfig").tsserver.setup {}  -- use "// @ts-check" in .js/.mjs files
require("lspconfig").bashls.setup {}
require("lspconfig").gopls.setup {}
require("lspconfig").rust_analyzer.setup {}

require("myconf.completion")
require("myconf.colours")
require("myconf.statusbar")

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions

-- Note:
--  :checkhealth is useful
