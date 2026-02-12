
" vim:ft=vim:

" Look in man 8 sshd for a lot more detail!
" Apparently a fourth column can exist with an identifying comment, but
" i've never seen that in the wild. Plus prefix markers.

if exists("b:current_syntax")
    finish
endif

"setlocal iskeyword=_,-,a-z,A-Z,48-57
"setlocal iskeyword+=-
syn iskeyword _,-,a-z,A-Z,48-57

syn match knownHostsIdentity '^[^ ]\+'
syn keyword knownHostsKeyType ssh-rsa ssh-dsa ssh-dss
syn keyword knownHostsKeyType ecdsa-sha2-nistp256 ecdsa-sha2-nistp384 ecdsa-sha2-nistp521
syn keyword knownHostsKeyType ssh-ed25519
syn match knownHostsComment '^#.*$'

hi def link knownHostsIdentity Function
hi def link knownHostsKeyType Keyword
hi def link knownHostsComment Comment

let b:current_syntax = "known_hosts"
