
-- These have no effect
--vim.opt.termguicolors = false
--vim.cmd [[ set notermguicolors ]]
--vim.cmd [[ set t_Co=0 ]]

-- First I start by vendoring in the "peachpuff" theme, but
-- deliberately only including the 16-colour version, because
-- the more colourful versions look awful.
-- Some things are commented out that mess things up.
vim.cmd [[
    "hi Normal ctermfg=black ctermbg=white cterm=NONE
    hi Folded ctermfg=darkblue ctermbg=NONE cterm=NONE
    hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
    hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=underline
    hi CursorLineNr ctermfg=NONE ctermbg=NONE cterm=underline
    hi QuickFixLine ctermfg=black ctermbg=grey cterm=NONE
    hi EndOfBuffer ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi StatusLine ctermfg=white ctermbg=black cterm=bold
    hi StatusLineNC ctermfg=white ctermbg=darkgrey cterm=bold
    hi StatusLineTerm ctermfg=white ctermbg=darkgreen cterm=bold
    hi StatusLineTermNC ctermfg=white ctermbg=darkcyan cterm=bold
    hi VertSplit ctermfg=white ctermbg=darkgrey cterm=NONE
    hi Pmenu ctermfg=black ctermbg=grey cterm=NONE
    hi PmenuSel ctermfg=black ctermbg=yellow cterm=bold
    hi PmenuSbar ctermfg=NONE ctermbg=white cterm=NONE
    hi PmenuThumb ctermfg=NONE ctermbg=darkgrey cterm=NONE
    hi TabLine ctermfg=white ctermbg=darkgrey cterm=underline
    hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=reverse
    hi TabLineSel ctermfg=black ctermbg=white cterm=bold
    hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ToolbarButton ctermfg=white ctermbg=darkgrey cterm=bold
    hi NonText ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi SpecialKey ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi Visual ctermfg=black ctermbg=grey cterm=NONE
    hi VisualNOS ctermfg=NONE ctermbg=darkgrey cterm=NONE
    hi LineNr ctermfg=red ctermbg=NONE cterm=NONE
    hi FoldColumn ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Underlined ctermfg=darkblue ctermbg=NONE cterm=underline
    hi Error ctermfg=darkred ctermbg=white cterm=bold,reverse
    hi ErrorMsg ctermfg=darkred ctermbg=white cterm=bold,reverse
    hi WarningMsg ctermfg=darkmagenta ctermbg=white cterm=bold
    hi MoreMsg ctermfg=darkgreen ctermbg=white cterm=bold
    hi ModeMsg ctermfg=black ctermbg=white cterm=bold
    hi Question ctermfg=darkred ctermbg=NONE cterm=bold
    hi Todo ctermfg=darkblue ctermbg=yellow cterm=NONE
    hi MatchParen ctermfg=white ctermbg=darkblue cterm=NONE
    hi Search ctermfg=white ctermbg=darkmagenta cterm=NONE
    hi IncSearch ctermfg=darkgreen ctermbg=NONE cterm=reverse
    hi WildMenu ctermfg=black ctermbg=yellow cterm=bold
    hi ColorColumn ctermfg=NONE ctermbg=grey cterm=NONE
    hi Cursor ctermfg=white ctermbg=black cterm=NONE
    hi lCursor ctermfg=black ctermbg=darkred cterm=NONE
    hi SpellBad ctermfg=darkred ctermbg=NONE cterm=underline
    hi SpellCap ctermfg=darkcyan ctermbg=NONE cterm=underline
    hi SpellLocal ctermfg=darkmagenta ctermbg=NONE cterm=underline
    hi SpellRare ctermfg=darkblue ctermbg=NONE cterm=underline
    hi Comment ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
    hi Identifier ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi Statement ctermfg=darkred ctermbg=NONE cterm=bold
    hi PreProc ctermfg=darkmagenta ctermbg=NONE cterm=NONE
    "hi Type ctermfg=darkgreen ctermbg=NONE cterm=bold
    hi Special ctermfg=darkblue ctermbg=NONE cterm=NONE
    hi Directory ctermfg=darkcyan ctermbg=NONE cterm=bold
    hi Conceal ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Title ctermfg=darkmagenta ctermbg=NONE cterm=bold
    "hi DiffAdd ctermfg=white ctermbg=darkgreen cterm=NONE
    "hi DiffChange ctermfg=white ctermbg=blue cterm=NONE
    hi DiffText ctermfg=black ctermbg=grey cterm=NONE
    hi DiffDelete ctermfg=white ctermbg=magenta cterm=NONE
]]

--  Then I tweak it a bit to better suit me
--  https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    "colorscheme peachpuff
    "highlight Normal ctermfg=NONE ctermbg=NONE cterm=NONE
    highlight Comment cterm=Italic ctermfg=62
    highlight Statement ctermfg=darkyellow ctermbg=NONE cterm=bold
    highlight Type ctermfg=darkgreen ctermbg=NONE cterm=NONE
    highlight LineNr ctermfg=lightgrey ctermbg=NONE cterm=NONE
    highlight SignColumn ctermbg=None
    highlight DiffAdd ctermbg=151
    highlight DiffChange ctermbg=223
]]
