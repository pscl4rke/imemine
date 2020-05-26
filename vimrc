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
" EXTENDED RUNTIME PATH
"   I add an additional path for vim to search in, which will only
"   contain syntax, which will be a link to the vim addons syntax
"   file provided by my package manager.  I do not add the addons
"   path directly because then I would get plugins, which change
"   vim's behaviour.  I only want the colours to be changed.
set runtimepath+=~/.vim_addons
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
set showmode
"
"
" COMMAND ENTRY
"   This tweaks this command line at the bottom of the screen to
"   behave a little more like readline.
"   (Unfortunately the command line only has whitespace-deletion and
"   does not support wordchar-deletion (Alt-BS).)
cnoremap <C-A> <Home>
cnoremap <Esc><BS> <BS>
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
set tabpagemax=40
"
"
" SYNTAX HIGHLIGHTING
"   Surely the most important part!  I enable it here and then set
"   some preferences.
"   Note that setting the background needs to come early, because
"   setting it automatically reloads the colour scheme ("default")
"   and resets any previous `highlight` directives.
"   One day I hope to have background autodetected from the
"   terminal settings.
syntax on
set background=light
let python_highlight_all = 1
let python_highlight_func_calls = 0
"
"
" POOR-MAN'S COLOUR SCHEME
"   Creating a full colour scheme was too much hard work, so
"   I stick with default and then tweak some things here.
highlight Comment ctermfg=DarkGreen cterm=Italic gui=Italic guifg=DarkGreen
highlight StatusLine term=reverse ctermbg=black ctermfg=gray
if &background == "light"
    highlight LineNr ctermfg=7
    highlight Statement ctermfg=3 cterm=bold term=bold
    highlight Type ctermfg=6 cterm=none
    highlight Function ctermfg=14 cterm=bold
    highlight pythonBuiltin ctermfg=6 cterm=bold
else
    highlight LineNr ctermfg=DarkBlue
    highlight Statement ctermfg=Yellow cterm=bold term=bold
    highlight Type ctermfg=Cyan
    highlight Function ctermfg=Cyan
endif
"
"
" SPELLING AND FORMATTING ERRORS
"   I hijack the syntax highlighting to make these clear.
highlight ExtraWhitespace ctermbg=red guibg=red term=reverse
autocmd BufNewFile,BufRead * match ExtraWhitespace /\s\+$/
highlight SpellBad term=reverse ctermbg=1 ctermfg=7
highlight SpellCap term=reverse ctermbg=4 ctermfg=7
highlight SpellLocal term=reverse ctermbg=6 ctermfg=7
highlight SpellRare term=reverse ctermbg=5 ctermfg=7
"
"
" DIFFING FILES
"   By default the vimdiff colours are unreadable.  These are
"   better, but still need tweaking.
highlight DiffAdd    cterm=bold ctermfg=Green   ctermbg=17
highlight DiffDelete cterm=bold ctermfg=Red     ctermbg=17
highlight DiffChange cterm=bold ctermfg=10      ctermbg=17
highlight DiffText   cterm=bold ctermfg=10      ctermbg=88
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
" FILE-TYPE DETECTION
"   Vim's usually pretty good at this sort of thing, but sometimes it
"   gets things wrong (and it does have an obsession with modula2).
"   I don't know whether 'set filetype=foo' is the right thing to use
"   here, or whether instead I should use 'setfiletype foo' or
"   'setlocal filetype=foo'.
"   Use setfiletype if you only want it to apply if there isn't
"   one already.
"   ALSO - What if newer vims already have these automatically?
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.pp set filetype=puppet
autocmd BufNewFile,BufRead *.csv set filetype=csv
autocmd BufNewFile,BufRead *.crontab set filetype=crontab
autocmd BufNewFile,BufRead [Ss][Cc]onstruct set filetype=python
autocmd BufNewFile,BufRead requirements.txt set filetype=conf
autocmd BufNewFile,BufRead *.rs set filetype=rust
autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile
autocmd BufNewFile,BufRead *.nfo set filetype=xml
autocmd BufNewFile,BufRead *.service set filetype=systemd
autocmd BufNewFile,BufRead *.env set filetype=dockerenv
autocmd BufNewFile,BufRead *.jinja set filetype=jinja
"
"
" FILE-TYPE PLUGINS
"   I could just add a 'filetype plugin on' setting here and that would
"   enable all the ftplugin files for all file types.  But I'm convinced
"   that would mess me around with lots of 'helpful' behaviour
"   alterations.  So I use this to enable them on a type-by-type basis.
"   Alternatively one can set a FileType preference in the section below.
"autocmd BufNewFile,BufRead *.t filetype plugin on | set ft=cram
"
"
" FILE-TYPE PREFERENCES
"   Sometimes a file type tries to be 'helpful'.
"   E.g. by default shell treats a dot as a word char
"   And sometimes I just need different behaviour
autocmd FileType sh setlocal iskeyword-=.
autocmd FileType nginx setlocal iskeyword-=/
autocmd FileType nginx setlocal iskeyword-=.
autocmd FileType coffee setlocal shiftwidth=2
autocmd FileType make setlocal noexpandtab
autocmd FileType calendar setlocal noexpandtab tabstop=20
autocmd FileType cram setlocal shiftwidth=2 tabstop=2
autocmd FileType gitconfig setlocal noexpandtab
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
"
"
" WORK SETTINGS
"   If I have additional commands in a work-specific file then
"   also run them too.
if filereadable($RVIMEMINE . "/vimrc.extra")
    source $RVIMEMINE/vimrc.extra
endif
"
"
" HISTORICAL
"   Some bits and pieces that were used, but not any more.
"set showmatch [Not needed in non compat. mode]
"
"
