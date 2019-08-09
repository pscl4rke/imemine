

"
" Some programs load configuration from 'env' files.  Systemd or
" Docker are good examples.  At first glance these look like shell,
" and could be sourced into shell scripts, and could even be
" highlighted as shell scripts in an editor.  However the programs
" do not execute the files as shell, and only allow lines of
" KEY=VALUE format and limited commenting.
"
" Wouldn't it be nice to have dedicated syntax type which helps
" avoid writing true shell by mistake.
"
" Somewhat based upon conf.vim and dosini.vim.  Try using example.env
" to confirm it works as expected.
"


" Comments...
syn keyword envTodo     contained TODO FIXME XXX
syn match   envComment  "^\s*#.*" contains=envTodo


" Key/Value...
syn match   envKey      "^\s*[^#=]*=" contains=envKeyErr nextgroup=envQuote


syn match   envKeyErr   "[^A-Za-z0-9_=]" contained
syn match   envKeyErr   "^[0-9]" contained


" And because quotes don't work like every other config format
" we assume they are a mistake mark them as if they are spelt wrong.
syn match   envQuote    "'" contained
syn match   envQuote    '"' contained
syn match   envQuote    " " contained


" Finally link matches to colours...
hi def link envComment  Comment
hi def link envTodo     Todo
hi def link envKeyErr   SpellBad
hi def link envQuote    SpellBad
hi def link envKey      Identifier
