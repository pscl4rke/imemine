
-- As per bittern


-- This is using paq because it promises compatibility with Debian Stable:
-- $ git clone https://github.com/savq/paq-nvim.git ~/.local/share/nvim/site/pack/paqs/start/paq-nvim
-- :PaqInstall
-- (errors in ~/.cache/nvim/paq.log or ~/.local/share/nvim/paq.log)


-- Realistically all these are going to get their versions pinned to be ones
-- that are compatible with my neovim instance!
require("paq") {

    -- Paq can manage itself after the initial bootstrapping:
    {"https://github.com/savq/paq-nvim"},

    -- Command Integration
    {"https://github.com/akinsho/toggleterm.nvim", branch = "v2.6.0"},

    -- Codebase Integration
    {"https://github.com/lewis6991/gitsigns.nvim", branch = "v0.6"},

    -- Opening
    {"https://github.com/junegunn/fzf", branch = "0.38.0"},
    {"https://github.com/jremmen/vim-ripgrep"},

    -- Language Integration
    {"https://github.com/neovim/nvim-lspconfig", branch = "v0.1.6"},

    -- Completion
    --  Unfortunately these need checking out at a specific commit into
    --  ~/.local/share/nvim/site/pack/paqs/start/ but git-clone can only
    -- take a branch or tag name as an argument
    --{"https://github.com/hrsh7th/nvim-cmp", branch = "ce16de5"},
    --{"https://github.com/hrsh7th/cmp-buffer", branch = "3022dbc"},
    --{"https://github.com/hrsh7th/cmp-path", branch = "91ff86c"},
    --{"https://github.com/hrsh7th/cmp-nvim-lsp", branch = "5af77f5"},

    -- Use Buffers Like Tabs
    {"https://github.com/akinsho/bufferline.nvim"},
    {"https://github.com/nvim-lualine/lualine.nvim"},

}

-- Configuration shared with normal vim
vim.cmd "source ~/imemine/vim/common.vim"


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

require("bufferline").setup {
    options = {
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end,
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

require("myconf.completion")
require("myconf.colours")
require("myconf.statusbar")

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions


-- Note:
--  :checkhealth is useful
