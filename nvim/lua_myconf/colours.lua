
-- Colours
--  Use a default, then tweak a little bit
--  Not in love with "peachpuff", but at least it's dark-on-light
--  https://www.ditig.com/256-colors-cheat-sheet
vim.cmd [[
    colorscheme peachpuff
    highlight Comment cterm=Italic ctermfg=62
    highlight SignColumn ctermbg=None
    highlight DiffAdd ctermbg=151
    highlight DiffChange ctermbg=223
]]
