

" Assorted settings shared between vim and neovim. Maybe vi too!
" Mostly this seems to just be keybindings for my muscle-memory.


" LONG LINES
"   Use arrow keys to navigate visual columns not logical columns
map <Down> gj
map <Up> gk


" LONG FILES
"   Act as a pager; replicate less
noremap <Space> <C-F>
"noremap g<Space> <Space>


" COMMAND ENTRY
"   Make the command line behave more like readline (bash etc).
"   (Unfortunately it only has whitespace-deletion and
"   does not support wordchar-deletion (Alt-BS).)
cnoremap <C-A> <Home>
cnoremap <Esc><BS> <BS>
set wildmode=longest,list
