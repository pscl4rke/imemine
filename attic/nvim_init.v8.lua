
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

    -- Trying out debugging
    {"https://codeberg.org/mfussenegger/nvim-dap", branch = "0.6.0"},  -- nvim 0.7 compat

}

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
require("lspconfig").tsserver.setup {}  -- use "// @ts-check" in .js/.mjs files
require("lspconfig").bashls.setup {}
require("lspconfig").gopls.setup {}
--require("lspconfig").rust_analyzer.setup {}

require("myconf.toggleterm")
require("myconf.gitsigns")
require("myconf.completion")
require("myconf.colours")
require("myconf.statusbar")
require("myconf.quickfix")

-- Testing Debugging
--  This is how to launch the adaptor (spelt as "adapter")...
require("dap").adapters.python = {
    type = "executable",
    command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter" },
}
--  And this is how the adaptor should run/connect to the program...
require("dap").configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        --console = "integratedTerminal",
        console = "externalTerminal",
    },
}
require("dap").defaults.fallback.external_terminal = {
    command = os.getenv("HOME") .. "/imemine/bin/open-in-terminal",
    --args = {},
}
vim.keymap.set('n', '<F4>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').repl.toggle() end)
-- DAP has been integrated into my lualine status bar config

-- Possibilities:
--  I don't use marks, so "m" and "'" could be rebound for other actions

-- Note:
--  :checkhealth is useful
