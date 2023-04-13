
" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "printmono"

hi Normal ctermfg=Black



"  Note that the 256 range of colours also works


" Paul's Additions:
"   'Blue' is actually pink
hi Unimportant ctermfg=Blue
"   printing code etc
hi Statement ctermfg=Black cterm=Bold
hi Conditional ctermfg=Black cterm=Bold
hi Repeat ctermfg=Black cterm=Bold
hi Include ctermfg=Black cterm=Bold
hi Function ctermfg=Black cterm=Bold

"   'Magenta' is actually light pink
"   'LightGreen' is actually mauve
"   'DarkGreen' really is green!
"   'DarkGrey' is actually green
"   'LightGrey' really is light grey!
hi Comment ctermfg=163 cterm=italic
"   used for potwiki links:
hi Identifier ctermfg=Black

" 'Yellow' is actually light blue
" 'DarkYellow' is actually green
hi LineNr ctermfg=DarkYellow

" 'DarkRed' is acually a royal blue
hi studyQ1 ctermfg=DarkRed cterm=Bold
hi studyQ2 ctermfg=DarkRed cterm=Bold
hi studyQ3 ctermfg=DarkRed cterm=Bold
hi studyQ4 ctermfg=DarkRed cterm=Bold
hi studyQ5 ctermfg=DarkRed cterm=Bold
hi studyImportant ctermfg=Black cterm=Bold,Underline,Italic
hi studyHeading ctermfg=Black cterm=Bold,Underline,Italic

