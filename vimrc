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
set scrolloff=3
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
" STATUS LINE
"   Now I say I always want a status line, and I give its format.
"   The format was originally based on one by Kim Schultz, but it has
"   been personalised since then.  I also say that I always want the
"   insert/replace etc mode to be indicated when active.
set laststatus=2
set statusline=%t%m%r%h%w\ [%{&ff}]\ (%Y)\ %=\ Ch\:\ \%03.3b\ (0x\%02.2B)\ %03lx%02v\ (%02.2p%%\ of\ %L)
hi StatusLine term=reverse ctermbg=black ctermfg=gray
set showmode
"
"
" INDENTATION
"   Set to satisfy the Python conventions, but generally usable for
"   everything else.  Note that when I really do want a tab character
"   I can just use Ctrl+V Ctrl+I.
set expandtab
set tabstop=4
set shiftwidth=4
"
"
" WINDOW TITLE
"   In an environment where Vim is able to set the title of the
"   terminal window use the full filename.
set titlestring=%t
set title
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
hi Comment ctermfg=DarkGreen
hi ExtraWhitespace ctermbg=red guibg=red term=reverse
match ExtraWhitespace /\s\+$/
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
"
"
" RARELY USED FEATURES
"   I rarely use the GUI, folding etc, but I have a few settings
"   that come into play.
" Use the indentation as a guide:
set foldmethod=indent
" But don't fold by default:
set nofoldenable
" Use a decent font in the GUI:
set guifont=Lucida_Sans_Typewriter:h10:cANSI
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
