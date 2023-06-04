
-- As per pendennis

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

end)

vim.o.wildmode = "longest,list"
vim.wo.number = true
vim.wo.numberwidth = 4

vim.o.scrolloff = 3

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

vim.keymap.set("n", "<space>", "<C-F>")
vim.keymap.set("n", "<C-L>", "<cmd>nohl<enter><C-L>")
vim.keymap.set("n", "gO", "<cmd>edit .<enter>")  -- NetRW or equiv
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")

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
require("lspconfig").pylsp.setup {}
require("lspconfig").tsserver.setup {}
require("lspconfig").bashls.setup {}

vim.o.completeopt = "menuone,noselect"
local cmp = require("cmp")
cmp.setup {
    sources = {
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp" },
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
    },
}

-- Colours
-- vim.cmd("colorscheme onedark")
-- https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    highlight Comment cterm=Italic ctermfg=62
    highlight SignColumn ctermbg=None
    highlight DiffAdd ctermbg=151
    highlight DiffChange ctermbg=223
]]

-- Note:
--  :checkhealth is useful
