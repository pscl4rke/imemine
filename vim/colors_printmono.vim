
" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "printmono"

hi Normal ctermfg=Black
"

" Paul's Additions:
"   'Blue' is actually pink
hi Unimportant ctermfg=Blue
"   used for potwiki links:
hi Identifier ctermfg=Black

" 'Yellow' is actually light blue
hi LineNr ctermfg=Yellow

" 'DarkRed' is acually a royal blue
hi studyQ1 ctermfg=DarkRed cterm=Bold
hi studyQ2 ctermfg=DarkRed cterm=Bold
hi studyQ3 ctermfg=DarkRed cterm=Bold
hi studyQ4 ctermfg=DarkRed cterm=Bold
hi studyQ5 ctermfg=DarkRed cterm=Bold

