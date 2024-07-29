
" as per vorpal

source ~/imemine/vim/common.vim

" THINGS BORROWED FROM VIMRC
set scrolloff=3
set numberwidth=4
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
noremap go :tabe<enter>:Files<enter>
noremap gO :tabe .<enter>
let g:netrw_liststyle = 3
noremap <Space> <C-F>
nnoremap <C-L> :nohl<CR><C-L>
map H :tabprev<enter>
map L :tabnext<enter>


" ALSO
set showtabline=2
tnoremap <esc> <c-\><c-n>
autocmd TermOpen * setlocal nonumber


" this would go to a bookmark
noremap gb :tabedit term://bash<enter>A


" INSTALLING AND ACTIVATING PLUGINS
"   First create ~/.local/share/nvim/site/autoload/ and then download into it
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   and then when you start it run :PlugInstall and wait.
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'navarasu/onedark.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'hrsh7th/nvim-compe'  " this has been deprecated in favour of cmp
call plug#end()


" USE THE PLUGINS
"   For onedark...
"colorscheme onedark
"   For gitgutter... (note that vim-signify autosaves!)
set signcolumn=yes
set updatetime=100
let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1
"let g:python3_host_prog = '~/.virtualenvs/neovim/bin/python3'
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
"

" Remember this is influenced by ~/.config/pycodestyle
lua require("lspconfig").pylsp.setup{
 \cmd={"/home/psc/.pip2bin/pylsp/bin/pylsp"}}

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.documentation = v:true
let g:compe.source = {}
let g:compe.source.buffer = v:true
let g:compe.source.path = v:true
let g:compe.source.nvim_lsp = v:true


"cnoremap <silent> q<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> qa<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> wq<CR> :echo "Do it Properly!"<CR>
"cnoremap <silent> wqa<CR> :echo "Do it Properly!"<CR>

colorscheme peachpuff
highlight Comment cterm=Italic ctermfg=62
highlight SignColumn ctermbg=None
highlight DiffAdd ctermbg=151
highlight DiffChange ctermbg=223
