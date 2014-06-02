"
"
"======================================================================"
"                        VIM CONFIGURATION FILE                        "
"======================================================================"
"
"
"     NOTE: Unusually, I do not like to have my editor set up
"       as an IDE.  I just want to edit text in it, and exit
"       back to the shell for everything else.  Hence there are
"       no fancy plugins here, and nothing is introduced that
"       would make the editor sluggish.
"
"
" PRESET CONFIGURATIONS
"   First things first, let me kill off compatibility with older
"   versions so I get the advanced features.  Then I begin
"   customising.
set nocompatible
"
"
" MISCELLANEOUS BEHAVIOUR
"   Some of the things that don't seem to have gone anywhere else.
"   Some of them may be defaults, but I've encountered places where
"   they aren't, so it's best to be explicit.
set scrolloff=3
set noautoindent
set timeoutlen=350
map Y y$
"
"
" DELETING TEXT
"   It's easier for me to alter vim to behave like the readline
"   defaults than it is to go through every host I manage and
"   alter readline to behave like vim.
"   (To get ^[ type ctrl+v and then escape.)
inoremap <BS> <C-W>
inoremap <C-W> <ESC>vBc
set backspace=indent,eol,start
"
"
" LINE NUMBERING
"   Default to using the left-most four characters for line numbers.
"   Note that this may mean making your terminal 84 characters wide,
"   although my habit of limiting to 72 means that this is rarely
"   a problem.  Note also that copying from the terminal may require
"   a :set nonu first.
set numberwidth=4
set number
hi LineNr ctermfg=DarkBlue
"
"
" SEARCHING {{{
"   Switching to interactive search, and using the screen refresh
"   shortcut to remove highlighting once done.
set incsearch
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>
"}}}
"
"
" STATUS LINE
"   Now I say I always want a status line, and I give its format.
"   The format was originally based on one by Kim Schultz, but it has
"   been personalised since then.  I also say that I always want the
"   insert/replace etc mode to be indicated when active.
set laststatus=2
set statusline=%t%m%r%h%w\ [%{&ff}\|%{&fenc}]\ (%Y)\ %=\ Ch\:\ \%03.3b\ (0x\%02.2B)\ %03lx%02v\ (%02.2p%%\ of\ %L)
hi StatusLine term=reverse ctermbg=black ctermfg=gray
set showmode
"
"
" INDENTATION
"   Set to satisfy the Python conventions, but generally usable for
"   everything else.  Note that when I really do want a tab character
"   I can just use Ctrl+V Ctrl+I.  The smarttab setting doesn't seem
"   to make a difference when indenting, but does when dedenting with
"   the backspace key.
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
"
"
" WINDOW TITLE
"   In an environment where Vim is able to set the title of the
"   terminal window use the full filename.
set titlestring=%t
set title
"
"
" TAB COMPLETION {{{
"   The tab completion on the command line is set to act more like
"   bash: filling out as much as it can and then offering suggestions.
set wildmode=longest,list
"}}}
"
"
" SETTING UP TABS
"   Tabs is a vastly superior way of working.  (In fact, I'm genuinely
"   surprised that it's not the default, and have aliased the -p into
"   my shell so that it is.)  It would normally have a maximum of 10
"   tabs, but I sometimes need more.
set tabpagemax=20
"
"
" SYNTAX HIGHLIGHTING
"   Surely the most important part!  I enable it here and then set
"   some preferences.
syntax on
hi Comment ctermfg=DarkGreen cterm=Italic gui=Italic guifg=DarkGreen
hi Statement ctermfg=Yellow
hi Type ctermfg=Cyan
hi Function ctermfg=Cyan
hi ExtraWhitespace ctermbg=red guibg=red term=reverse
au BufNewFile,BufRead * match ExtraWhitespace /\s\+$/
let python_highlight_numbers = 1
let python_highlight_builtins = 1
"
"
" MANAGING EVIL
"   For those cases where a single line is far longer than it ever
"   should be I set up the arrow keys to work to my advantage.
map <Down> gj
map <Up> gk
"
"
" HUMAN FAILURES
"   Because sometimes you hit the wrong key and you just want it
"   to work!
imap <F1> <ESC>
map <F1> <ESC>
map Q W
noremap <Space> <C-F>
noremap g<Space> <Space>
"
"
" FILE-TYPE DETECTION {{{
"   Vim's usually pretty good at this sort of thing, but sometimes it
"   gets things wrong (and it does have an obsession with modula2).
"   I don't know whether 'set filetype=foo' is the right thing to use
"   here, or whether instead I should use 'setfiletype foo' or
"   'setlocal filetype=foo'.
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.pp set filetype=puppet
autocmd BufNewFile,BufRead *.csv set filetype=csv
autocmd BufNewFile,BufRead *.crontab set filetype=crontab
autocmd BufNewFile,BufRead [Ss][Cc]onstruct set filetype=python
"}}}
"
"
" FILE-TYPE PREFERENCES
"   Sometimes a file type tries to be 'helpful'.
"   E.g. by default shell treats a dot as a word char
"   And sometimes I just need different behaviour
autocmd FileType sh setlocal iskeyword-=.
autocmd FileType coffee setlocal shiftwidth=2
autocmd FileType make setlocal noexpandtab
"
"
" GUI OPTIONS
"   They don't get much use, but I have some preferences for the GUI.
"   I believe it is possible to set a list of fonts, but I'm picking
"   only one for the time being.
"set guifont=Lucida_Sans_Typewriter:h14:cANSI
set guifont=Monospace\ 11
"
"
" PSEUDO-LEADER
"   I tried out lots of different things for leaders, but eventually
"   settled on defining everything twice using Ctrl+\
"   -   This won't clash with plugins that use <Leader> because
"       that is just a backslash without the Ctrl
"   -   It is better than a comma because Ctrl+Comma can't
"       be mapped
"   -   WORRYINGLY: Ctrl+Backlash often gets mapped to SIGQUIT
"   -   It works in both modes in the terminal (URXVT, Xterm, ST)
noremap <C-\>n :set number!<CR>
inoremap <C-\>n <C-O>:set number!<CR>
noremap <C-\>p :filetype plugin on<CR>:do FileType<CR>
inoremap <C-\>p <C-O>:filetype plugin on<CR><C-O>:do FileType<CR>
noremap <C-\>s :set spell!<CR>
inoremap <C-\>s <C-O>:set spell!<CR>
"
"
" RARELY USED FEATURES
"   I rarely use folding etc, but I have a few settings
"   that come into play.
" Use the indentation as a guide:
set foldmethod=indent
" But don't fold by default:
set nofoldenable
" When highlighting spelling mistakes, use a different foreground:
hi SpellBad term=reverse ctermbg=1 ctermfg=7
hi SpellCap term=reverse ctermbg=4 ctermfg=7
hi SpellLocal term=reverse ctermbg=6 ctermfg=7
hi SpellRare term=reverse ctermbg=5 ctermfg=7
"
"
" HISTORICAL
"   Some bits and pieces that were used, but not any more.
"set showmatch [Not needed in non compat. mode]
"
"
