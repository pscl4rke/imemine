
" Perhaps in future I could use
"   https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

" BORROWED FROM VIMRC
set scrolloff=3
set numberwidth=4
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
let g:netrw_liststyle = 3
noremap <Space> <C-F>
nnoremap <C-L> :nohl<CR><C-L>
map Y y$


" USEFUL PASTING
imap <S-Insert> <C-R>*


" INSTALLING AND ACTIVATING PLUGINS
"   First create ~/.local/share/nvim/site/autoload/ and then download into it
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   and then when you start it run :PlugInstall and wait.
call plug#begin()
Plug 'https://github.com/junegunn/fzf.git', {'tag': '0.20.0'}
Plug 'https://github.com/akinsho/toggleterm.nvim.git'
" note that vim-signify autosaves!
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-surround.git'
"Plug 'https://github.com/rakr/vim-one.git'
Plug 'https://github.com/romainl/flattened.git'
Plug 'https://github.com/neovim/nvim-lspconfig.git'
Plug 'https://github.com/hrsh7th/nvim-cmp.git'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp.git'
Plug 'https://github.com/hrsh7th/cmp-buffer.git'
Plug 'https://github.com/hrsh7th/cmp-path.git'
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
call plug#end()


noremap gO <cmd>tabedit .<enter>
noremap go <cmd>tabedit<enter><cmd>FZF<enter>


cnoremap <silent> q<CR> :echo "Do it Properly!"<CR>
cnoremap <silent> qa<CR> :echo "Do it Properly!"<CR>
cnoremap <silent> wq<CR> :echo "Do it Properly!"<CR>
cnoremap <silent> wqa<CR> :echo "Do it Properly!"<CR>

lua require("toggleterm").setup {
\   open_mapping = [[<c-\>]],
\   direction = 'float',
\}
" don't discard terminal when hidden
set hidden

" for gitgutter
set signcolumn=yes
set updatetime=100
let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1

"colorscheme one
"set background=light
"colorscheme flattened_light
colorscheme myflattened

" Remember this is influenced by ~/.config/pycodestyle
lua require("lspconfig").pylsp.setup{
 \cmd={"/home/psc/.pip2bin/pylsp/bin/pylsp"}}

lua require("lspconfig").tsserver.setup{
 \ cmd={"/home/psc/.npm2bin/typescript/node_modules/.bin/typescript-language-server", "--stdio"}
 \}

set completeopt=menu,menuone,noselect
"lua require("cmp").setup()
"lua require("cmp").config.sources({
"\   { name = "buffer" },
"\})
lua <<EOF
local cmp = require 'cmp'
cmp.setup {
  -- snippet = {
  --   expand = function(args)
  --     luasnip.lsp_expand(args.body)
  --   end,
  -- },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    --{ name = 'buffer', get_bufnrs = vim.api.nvim_list_bufs },
    { name = 'buffer' },
    { name = 'path' },
  },
}
EOF
