
"noremap gO :tabe .<enter>
let g:netrw_liststyle = 3

"call plug#begin('~/.vim/plugged')
call plug#begin()

"Plug 'tpope/vim-fugitive'
" note that vim-signify autosaves!
Plug 'airblade/vim-gitgutter'

Plug 'navarasu/onedark.nvim'

"Plug 'Famiu/feline.nvim'
"Plug 'romgrk/barbar.nvim'
"Plug 'akinsho/nvim-bufferline.lua'
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'kyazdani42/nvim-tree.lua'
"Plug 'gcmt/taboo.vim'
Plug 'seblj/nvim-tabline'

""Plug 'windwp/nvim-autopairs'
"Plug 'steelsojka/pears.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" One day replace with LSP...
"Plug 'deoplete-plugins/deoplete-jedi'

Plug 'neovim/nvim-lspconfig'

"Plug 'deoplete-plugins/deoplete-lsp'

"Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/nvim-compe'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'jremmen/vim-ripgrep'

call plug#end()

" Now run :PlugInstall

set signcolumn=yes
set updatetime=100

"let g:onedark_style = 'darker'
colorscheme onedark

let g:nvim_tree_auto_open = 1

"lua require "pears".setup()
"lua <<EOF
"require "pears".setup()
"EOF

let g:python3_host_prog = '/home/psc/.virtualenvs/neovim/bin/python3'

"let g:UltiSnipsExpandTrigger="<tab>" " DEFAULT
" don't class with deoplete...
" ctrl+j is also the key ultisnips uses for jump-to-next-tabstop
"let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsExpandTrigger="<c-j>"

let g:deoplete#enable_at_startup = 1
"set completeopt=longest,menuone
"set completeopt=menuone,noinsert,noselect
set completeopt=menuone,noselect
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
"autocmd BufNewFile,BufRead * inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

lua require("nvim-web-devicons").setup({ default = true })
"lua require("feline").setup()
lua require('tabline').setup{
 \ always_show_tabs = true,
 \ }

noremap gO <cmd>tabedit .<enter>
noremap go <cmd>tabedit<enter><cmd>Files<enter>

function! RgPrompt()
    call inputsave()
    let query = input('Ripgrep query: ')
    call inputrestore()
    "call Rg(query)
    exec 'Rg ' . query
endfunction
noremap g/ <cmd>tabedit<enter><cmd>call RgPrompt()<enter>

""set guifont=DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete
"let g:nvim_tree_tab_open = 1
""lua vim.g.nvim_tree_bindings
"lua <<EOF
"local tree_cb = require'nvim-tree.config'.nvim_tree_callback
"vim.g.nvim_tree_bindings = {
"    ["<CR>"] = tree_cb("tabnew")
"}
"EOF
"let g:nvim_tree_auto_open = 1
"let g:nvim_tree_quit_on_open = 1

"lua require("bufferline").setup{}

"let g:deoplete#sources#jedi#python_path = '/home/psc/.pip2bin/jedi/bin/python'

tnoremap <esc> <c-\><c-n>

lua require("lspconfig").pylsp.setup{
 \cmd={"/home/psc/.pip2bin/pylsp/bin/pylsp"}}

lua require'lspconfig'.tsserver.setup{
 \ cmd = {"/home/psc/.npm2bin/typescript/node_modules/.bin/typescript-language-server", "--stdio"}
 \}

"autocmd BufEnter * lua require'completion'.on_attach()
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
