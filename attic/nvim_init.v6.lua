
-- As per zenbook yet again

-- Note: this uses packer. But could try
--  https://github.com/savq/paq-nvim/
-- which advertises compatibility with Debian Stable

-- $ mkdir -p ~/.local/share/nvim/site/pack/packer/start/
-- $ git clone https://github.com/wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- :PackerSync


require("packer").startup(function(use)

    -- Packer can manage itself after the initial bootstrapping:
    use {"https://github.com/wbthomason/packer.nvim"}

    -- Command Integration
    use {"https://github.com/akinsho/toggleterm.nvim"}
    use {"https://github.com/neomake/neomake"}

    -- Codebase Integration
    use {"https://github.com/lewis6991/gitsigns.nvim", tag = "v0.6"}

    -- Opening
    use {"https://github.com/junegunn/fzf", tag = "0.20.0"}
    --use {"https://github.com/junegunn/fzf.vim"}  -- :Lines, :BLines
    use {"https://github.com/jremmen/vim-ripgrep"}

    -- Language Integration
    use {"https://github.com/neovim/nvim-lspconfig"}

    -- Completion
    use {"https://github.com/hrsh7th/nvim-cmp"}
    use {"https://github.com/hrsh7th/cmp-buffer"}
    use {"https://github.com/hrsh7th/cmp-path"}
    use {"https://github.com/hrsh7th/cmp-nvim-lsp"}

    -- Use Buffers Like Tabs
    use {"https://github.com/akinsho/bufferline.nvim"}
    use {"https://github.com/nvim-lualine/lualine.nvim"}

    -- TESTING:
    --use {"https://github.com/kyazdani42/nvim-web-devicons"}
    --use {"https://github.com/navarasu/onedark.nvim"}

end)

vim.o.wildmode = "longest,list"
vim.wo.number = true
vim.wo.numberwidth = 4
vim.o.scrolloff = 3

-- Sensible defaults for many files
--  Is this not the sort of thing LSP could override???
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

vim.o.scrolloff = 3

-- Command
require("toggleterm").setup {
    open_mapping = [[<C-\>]],
    direction = "float",
}

vim.g.neomake_open_list = 1
--vim.cmd("call neomake#config#set('maker_defaults.buffer_output', 0)")
--vim.g.neomake_makeprg_makeprg_buffer_output = 0

-- VCS
--  FIXME colour backgrounds
vim.wo.signcolumn = "yes"
require("gitsigns").setup {
    numhl = true,
    linehl = true,
}

vim.keymap.set("n", "<space>", "<C-F>")
vim.keymap.set("n", "<C-L>", "<cmd>nohl<enter><C-L>")

vim.keymap.set("n", "go", "<cmd>FZF<enter>")
--vim.keymap.set("n", "go", "<cmd>Files<enter>") -- has preview
vim.keymap.set("n", "gO", "<cmd>GFiles<enter>") -- git ls-files
vim.keymap.set("n", "gl", "<cmd>Lines<enter>")
vim.keymap.set("n", "MM", "<cmd>make<enter>")
--vim.keymap.set("n", "MM", "<cmd>Neomake!<enter><cmd>copen<enter>")
vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")
--vim.keymap.set("n", "H", "<cmd>bnext<enter>")  -- breaks with quickfix
--vim.keymap.set("n", "L", "<cmd>bnext<enter>")  -- breaks with quickfix
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
vim.keymap.set("n", "g/", function()
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query) -- shortcut for vim.api.nvim_command
end)
vim.keymap.set("n", "g]", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

require("bufferline").setup {
    --options = {separator_style = "slant"},
    --options = {separator_style = {"/", "\\"}},
    options = {
        custom_filter = function(buf_number, buf_numbers)
            -- Messes stuff up?!?
            --if vim.bo[buf_number].filetype == "make" then  -- makeprg result
            --    return false
            --end
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
    }
}

-- Status Bar
require("lualine").setup {
    options = {
        theme = "everforest", -- or "16color"
        icons_enabled = false,
        component_separators = "",
        section_separators = "",
    },
    sections = {
        -- [a|b|c...x|y|z]
        lualine_a = {"filename", "%m%r%h%w"},
        lualine_b = {"fileformat", "encoding", "filetype"},
        lualine_c = {"diagnostics"},
        lualine_x = {"branch", "diff"},
        lualine_y = {"%03.3b", "%(%)0x%02.2B"},  -- the %(%) fools lualine into interpretting %
        lualine_z = {"location", "progress", "%L"},
    },
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
require("lspconfig").pylsp.setup {
    -- Remember this is influenced by ~/.config/pycodestyle
    --cmd = {"/home/psc/.pip2bin/pylsp/bin/pylsp"},
}
require("lspconfig").tsserver.setup {
    --cmd = {"/home/psc/.npm2bin/typescript/node_modules/.bin/typescript-language-server",
    --       "--stdio"},
}
require("lspconfig").bashls.setup {}

-- not sure if this line affects anything in the cmp world...
--vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")
cmp.setup {
    preselect = cmp.PreselectMode.None,  -- esp for gopls
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
            select = false,  -- don't autocomplete end of comment!
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
--  Use a default, then tweak a little bit
--  Not in love with "peachpuff", but at least it's dark-on-light
--  https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    colorscheme peachpuff
    highlight Comment cterm=Italic ctermfg=62
    highlight SignColumn ctermbg=None
    highlight DiffAdd ctermbg=151
    highlight DiffChange ctermbg=223
]]

-- Also to research
--  makeprg
--  quickfix
--  switchbuf
--  plugin: neomake/neomake

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions


-- Note:
--  :checkhealth is useful
