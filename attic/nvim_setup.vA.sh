set -eu

basedir="$HOME/.local/share/nvim/site/pack/psc/start"

# The versions here are tested to be functional with Neovim v0.9

git ensure-repo \
    "$basedir/toggleterm.nvim" \
    "https://github.com/akinsho/toggleterm.nvim.git" \
    "v2.13.1"

git ensure-repo \
    "$basedir/gitsigns.nvim" \
    "https://github.com/lewis6991/gitsigns.nvim.git" \
    "v1.0.2"

# The version of this must exactly match /usr/bin/fzf
git ensure-repo \
    "$basedir/fzf" \
    "https://github.com/junegunn/fzf.git" \
    "0.44.1"

git ensure-repo \
    "$basedir/vim-ripgrep" \
    "https://github.com/jremmen/vim-ripgrep" \
    "v1.0.3"

git ensure-repo \
    "$basedir/nvim-lspconfig" \
    "https://github.com/neovim/nvim-lspconfig.git" \
    "v1.8.0"

git ensure-repo \
    "$basedir/nvim-cmp" \
    "https://github.com/hrsh7th/nvim-cmp.git" \
    "v0.0.2"

git ensure-repo \
    "$basedir/cmp-buffer" \
    "https://github.com/hrsh7th/cmp-buffer.git" \
    "main"

git ensure-repo \
    "$basedir/cmp-path" \
    "https://github.com/hrsh7th/cmp-path.git" \
    "main"

git ensure-repo \
    "$basedir/cmp-nvim-lsp" \
    "https://github.com/hrsh7th/cmp-nvim-lsp.git" \
    "main"

git ensure-repo \
    "$basedir/lualine.nvim" \
    "https://github.com/nvim-lualine/lualine.nvim.git" \
    "master"

git ensure-repo \
    "$basedir/bufferline.nvim" \
    "https://github.com/akinsho/bufferline.nvim.git" \
    "v4.9.1"

echo
echo DONE
