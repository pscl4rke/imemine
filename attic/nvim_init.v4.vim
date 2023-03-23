
" As per excalibur

" Perhaps in future I could use
"   https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
"   (lots of people are liking lazy.nvim for handling dependencies now)

" BORROWED FROM VIMRC
set scrolloff=3
set numberwidth=4
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set showtabline=2  " always
let g:netrw_liststyle = 3
noremap <Space> <C-F>
nnoremap <C-L> :nohl<CR><C-L>
map Y y$


" USEFUL PASTING
imap <S-Insert> <C-R>*



" Probably replace with buffers not tabs...
nmap H :tabprev<enter>
nmap L :tabnext<enter>


" INSTALLING AND ACTIVATING PLUGINS
"   First create ~/.local/share/nvim/site/autoload/ and then download into it
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   and then when you start it run :PlugInstall and wait.
call plug#begin()
Plug 'https://github.com/junegunn/fzf.git', {'tag': '0.20.0'}
"Plug 'https://github.com/junegunn/fzf.vim.git', {'tag': '0.20.0'}
Plug 'https://github.com/jremmen/vim-ripgrep.git'
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


"noremap gO <cmd>tabedit .<enter>
noremap go <cmd>tabedit<enter><cmd>FZF<enter>
"noremap go <cmd>tabedit<enter><cmd>GFiles<enter>
"noremap gO <cmd>tabedit<enter><cmd>Files<enter>
"noremap gl <cmd>tabedit<enter><cmd>Lines<enter>
" The following doesn't work properly!
noremap g/ <cmd>tabnew<enter><cmd>Rg <enter>

noremap g] <cmd>lua vim.lsp.buf.definition()<enter>
noremap K <cmd>lua vim.lsp.buf.hover()<enter>


"cnoremap <silent> q<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> qa<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> wq<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> wqa<CR> :echo "Do it Properly!"<CR>

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
"""""""""""""""""""""""""""""""2colorscheme myflattened
"hi DiffAdd                                 cterm=NONE  ctermbg=7  gui=NONE  guibg=#eef4d5  guisp=#719e07  gui=NONE
"hi DiffChange                              cterm=NONE  ctermbg=7  gui=NONE  guibg=#f8ebd5  guisp=#b58900  gui=NONE
"hi DiffDelete                              cterm=NONE  ctermbg=7  gui=NONE  guibg=#eee8d5  gui=NONE
"hi DiffText                                cterm=NONE  ctermfg=4  ctermbg=7  gui=NONE  guifg=#268bd2  guibg=#eee8d5  guisp=#268bd2  gui=NONE

" Remember this is influenced by ~/.config/pycodestyle
lua require("lspconfig").pylsp.setup{
 \cmd={"/home/psc/.pip2bin/pylsp/bin/pylsp"}}

lua require("lspconfig").tsserver.setup{
 \ cmd={"/home/psc/.npm2bin/typescript/node_modules/.bin/typescript-language-server", "--stdio"}
 \}

"lua require("lspconfig").bashls.setup {
" \ cmd={"/home/psc/.npm2bin/bash-language-server/node_modules/.bin/bash-language-server",
" \"start"},
" \}

"set completeopt=menu,menuone,noselect
set completeopt=menuone,noselect
"lua require("cmp").setup()
"lua require("cmp").config.sources({
"\   { name = "buffer" },
"\})
lua <<EOF
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      --luasnip.lsp_expand(args.body)
        print(vim.inspect(args))
        -- print(args.body)
        --return args.body
        --vim.fn["vsnip#anonymous"](args.body)
        local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_text(0, line_num - 1, col, line_num -1, col, { args.body })
    end,
  },
  --snippet = false,
  -- snippet = {
  --   expand = function(args)
  --     unpack = unpack or table.unpack
  --     local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
  --     local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
  --     local indent = string.match(line_text, '^%s*')
  --     local replace = vim.split(args.body, '\n', true)
  --     local surround = string.match(line_text, '%S.*') or ''
  --     local surround_end = surround:sub(col)

  --     replace[1] = surround:sub(0, col - 1)..replace[1]
  --     replace[#replace] = replace[#replace]..(#surround_end > 1 and ' ' or '')..surround_end
  --     if indent ~= '' then
  --       for i, line in ipairs(replace) do
  --         replace[i] = indent..line
  --       end
  --     end

  --     vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
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
        cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
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
