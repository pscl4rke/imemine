
-- As per zenbook yet again

-- $ mkdir -p ~/.local/share/nvim/site/pack/packer/start/
-- $ git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- :PackerSync


require("packer").startup(function(use)

    --  Packer can manage itself after the initial bootstrapping:
    use {"https://github.com/wbthomason/packer.nvim"}

    -- Command Integration
    use {"https://github.com/akinsho/toggleterm.nvim"}
    --use {"https://github.com/neomake/neomake"}

    --  VCS Integration
    use {"https://github.com/lewis6991/gitsigns.nvim"}

    --  Opening
    use {"https://github.com/junegunn/fzf.git"}
    use {"https://github.com/jremmen/vim-ripgrep"}

    --  Language Integration
    use {"https://github.com/neovim/nvim-lspconfig.git"}

    --  Completion
    use {"https://github.com/hrsh7th/nvim-cmp.git"}
    use {"https://github.com/hrsh7th/cmp-buffer.git"}
    use {"https://github.com/hrsh7th/cmp-path.git"}
    use {"https://github.com/hrsh7th/cmp-nvim-lsp.git"}

    --  TESTING:
    use {"https://github.com/kyazdani42/nvim-web-devicons"}
    use {"https://github.com/navarasu/onedark.nvim"}
    use {"https://github.com/akinsho/bufferline.nvim"}

end)

vim.o.wildmode = "longest,list"
vim.wo.number = true

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

vim.keymap.set("n", "go", "<cmd>FZF<enter>")
--vim.keymap.set("n", "H", "<cmd>bnext<enter>")  -- breaks with quickfix
--vim.keymap.set("n", "L", "<cmd>bnext<enter>")  -- breaks with quickfix
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
vim.keymap.set("n", "g/", function()
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query) -- shortcut for vim.api.nvim_command
end)
vim.keymap.set("n", "g]", vim.lsp.buf.definition)

-- Language Integration
require("lspconfig").pylsp.setup {
    cmd = {"/home/psc/.pip2bin/pylsp/bin/pylsp"},
}

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

-- TESTING:
vim.cmd("colorscheme onedark")
require("bufferline").setup {
    --options = {separator_style = "slant"},
    --options = {separator_style = {"/", "\\"}},
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
    }
}

-- Also to research
--  makeprg
--  quickfix
--  switchbuf
