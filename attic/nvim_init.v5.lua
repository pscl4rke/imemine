
-- Experimental version 5, as per lithium

-- Somewhat inspired by https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--  except that repo has now been obliterated by the original author.
--  so instead try https://github.com/Gavinok/Kickstart.nvim
--  or try https://github.com/ifnk/kickstart.nvim

-- $ mkdir -p ~/.local/share/nvim/site/pack/packer/start/
-- $ git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- :PackerSync


require("packer").startup(function(use)

    use "https://github.com/junegunn/fzf.git"

    -- Command Integration
    use "https://github.com/akinsho/toggleterm.nvim.git"

    --  VCS Integration
    -- use "https://github.com/airblade/vim-gitgutter"
    use "https://github.com/lewis6991/gitsigns.nvim.git"

    --  Language Integration
    use "https://github.com/neovim/nvim-lspconfig.git"

    --  Completion
    use "https://github.com/hrsh7th/nvim-cmp.git"
    use "https://github.com/hrsh7th/cmp-buffer.git"
    use "https://github.com/hrsh7th/cmp-path.git"
    use "https://github.com/hrsh7th/cmp-nvim-lsp.git"

    -- maybe https://github.com/duane9/nvim-rg
    use "https://github.com/jremmen/vim-ripgrep.git"

    use "https://github.com/akinsho/bufferline.nvim"

end)
-- Now run :PackerSync

-- Here's looking at you HTML...
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.wildmode = "longest,list"
vim.wo.number = true

-- Indentation
--  Naive (copy previous line) on, but fancy stuff kept over-indenting
vim.o.autoindent = true
vim.cmd("filetype plugin indent off")

vim.o.showtabline = 2  -- always
--vim.o.switchbuf = "newtab"

vim.keymap.set("n", "<space>", "<C-F>")

--vim.keymap.set("n", "gO", "<cmd>tabedit .<enter>")  -- NetRW or equiv
--vim.keymap.set("n", "go", "<cmd>tabnew<enter><cmd>FZF<enter>")
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
vim.keymap.set("n", "g/", function()
    --vim.cmd("tabnew") -- shortcut for vim.api.nvim_command
    --vim.cmd("redraw")
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query)
end)

-- Probably replace with buffers not tabs...
--vim.keymap.set("n", "H", "<cmd>tabprev<enter>")
--vim.keymap.set("n", "L", "<cmd>tabnext<enter>")
--vim.keymap.set("n", "H", "<cmd>bnext<enter>")  -- breaks with quickfix
--vim.keymap.set("n", "L", "<cmd>bnext<enter>")  -- breaks with quickfix
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")

vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")

vim.keymap.set("n", "g]", function()
    --vim.cmd("tabnew") -- shortcut for vim.api.nvim_command
    --vim.lsp.buf.definition()
    --vim.lsp.buf.definition({ reuse_win = false })
    --vim.lsp.buf.definition(false)
end)
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- Command
require("toggleterm").setup {
    open_mapping = [[<C-\>]],
    direction = "float",
}

-- VCS
vim.wo.signcolumn = "yes"
require("gitsigns").setup {
    numhl = true,
    linehl = true,
}

-- Fake "Tabs"
require("bufferline").setup {}

-- Language Integration
require("lspconfig").pylsp.setup {
    cmd = {"/home/psc/.pip2bin/pylsp/bin/pylsp"},
}

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

-- https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    highlight Comment cterm=Italic ctermfg=62
    highlight SignColumn ctermbg=None
    highlight DiffAdd ctermbg=194
    highlight DiffChange ctermbg=223
]]

-- Note:
--  :checkhealth is useful
-- also see https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
