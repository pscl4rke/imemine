
-- Experimental version 5, as per lithium

-- Somewhat inspired by https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--  except that repo has now been obliterated by the original author.
--  so instead try https://github.com/Gavinok/Kickstart.nvim
--  or try https://github.com/ifnk/kickstart.nvim

-- $ mkdir -p ~/.local/share/nvim/site/pack/packer/start/
-- $ git clone https://github.com/wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- :PackerSync


require("packer").startup(function(use)

    -- Packer can manage itself after the initial bootstrapping:
    use {"https://github.com/wbthomason/packer.nvim"}

    -- Command Integration
    use "https://github.com/akinsho/toggleterm.nvim.git"

    -- Codebase Integration
    use "https://github.com/lewis6991/gitsigns.nvim.git"
    -- Opening
    use {"https://github.com/junegunn/fzf", tag = "0.20.0"}
    use "https://github.com/junegunn/fzf.vim.git"
    -- maybe https://github.com/duane9/nvim-rg
    use "https://github.com/jremmen/vim-ripgrep.git"

    -- Language Integration
    use "https://github.com/neovim/nvim-lspconfig.git"

    -- Completion
    use "https://github.com/hrsh7th/nvim-cmp.git"
    use "https://github.com/hrsh7th/cmp-buffer.git"
    use "https://github.com/hrsh7th/cmp-path.git"
    use "https://github.com/hrsh7th/cmp-nvim-lsp.git"

    -- Use Buffers Like Tabs
    use "https://github.com/akinsho/bufferline.nvim"  -- .git
    --use "https://github.com/romgrk/barbar.nvim.git"
    --https://github.com/kdheepak/tabline.nvim ??
    use "https://github.com/nvim-lualine/lualine.nvim.git"

end)

-- Configuration shared with normal vim
vim.cmd "source ~/imemine/vim/common.vim"

-- Layout
vim.o.wildmode = "longest,list"
vim.wo.number = true
vim.wo.numberwidth = 4
vim.o.scrolloff = 3
vim.o.title = true

-- Here's looking at you HTML...
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- maybe default?
vim.o.hlsearch = true
-- testing out
vim.o.ignorecase = true
vim.o.smartcase = true

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


-- Indentation
--  Naive (copy previous line) on, but fancy stuff kept over-indenting
vim.o.autoindent = true
vim.cmd("filetype plugin indent off")

vim.o.showtabline = 2  -- always
--vim.o.switchbuf = "newtab"

--vim.keymap.set("n", "go", "<cmd>tabnew<enter><cmd>FZF<enter>")
vim.keymap.set("n", "go", "<cmd>FZF<enter>")
--vim.keymap.set("n", "gO", "<cmd>tabedit .<enter>")  -- NetRW or equiv
vim.keymap.set("n", "gO", "<cmd>edit .<enter>")  -- NetRW or equiv
vim.keymap.set("n", "gl", "<cmd>Lines<enter>")
vim.keymap.set("n", "gG", "<cmd>GFiles<enter>") -- not gitignored, but includes parent dirs
vim.keymap.set("n", "g/", function()
    local query = vim.fn.input("Ripgrep prompt: ")
    vim.cmd("Rg " .. query) -- shortcut for vim.api.nvim_command
end)

-- Probably replace with buffers not tabs...
--vim.keymap.set("n", "H", "<cmd>tabprev<enter>")
--vim.keymap.set("n", "L", "<cmd>tabnext<enter>")
--vim.keymap.set("n", "H", "<cmd>bnext<enter>")  -- breaks with quickfix
--vim.keymap.set("n", "L", "<cmd>bnext<enter>")  -- breaks with quickfix
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<enter>")
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<enter>")
--vim.keymap.set("n", "H", "<cmd>BufferPrevious<enter>")
--vim.keymap.set("n", "L", "<cmd>BufferNext<enter>")

vim.keymap.set("n", "ZZ", "<cmd>write<enter><cmd>bdelete<enter>")

--vim.keymap.set("n", "g]", function()
    --vim.cmd("tabnew") -- shortcut for vim.api.nvim_command
    --vim.lsp.buf.definition()
    --vim.lsp.buf.definition({ reuse_win = false })
    --vim.lsp.buf.definition(false)
--end)
vim.keymap.set("n", "g]", vim.lsp.buf.definition)
vim.keymap.set("n", "g[", vim.lsp.buf.references)
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- Fake "Tabs"
-- The trouble with bufferline is that it doesn't shrink tabs to fit
require("bufferline").setup {
    options = {
        --enforce_regular_tabs = false,
        --truncate_names = false,
        --tab_size = 0,
        --max_name_length = 0,
        --indicator = { style = "none" },
        --show_close_icon = false,
        --show_buffer_icons = false,
        show_buffer_close_icons = false,
        --separator_style = {"|", "|"},
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "qf" then  -- quickfix
                return true
            end
        end
    },
    --highlights = {
    --    buffer_selected = { fg = "#ff0000", italic = true },
    --    fill = { fg = "#00ff00" },
    --},
}
-- This doesn't shrink tabs either
--require("bufferline").setup {  -- really barbar
--    auto_hide = false,
--    --icons = { filetype = { enabled = false } },
--    --icons = {current = {filetype = {enabled = false}}},
--}
--vim.cmd [[
--    highlight BufferCurrent ctermfg=Black
--    highlight BufferVisible ctermfg=DarkGrey
--]]
--require("bufferline.options").maximum_length = function () return 5 end

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
-- also see https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
