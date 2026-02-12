
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

" Expect the identity at the start of the line, then try for key type straight afterwards:
syn match knownHostsIdentity '^[^ ]\+' nextgroup=knownHostsKeyTypeWrapper skipwhite

" The key type only comes after identity, and is marked as an error except for types:
syn match knownHostsKeyTypeWrapper '\S\+' contained contains=knownHostsKeyType
syn keyword knownHostsKeyType contained ssh-rsa ssh-dsa ssh-dss
syn keyword knownHostsKeyType contained ecdsa-sha2-nistp256 ecdsa-sha2-nistp384 ecdsa-sha2-nistp521
syn keyword knownHostsKeyType contained ssh-ed25519

" Hashes seem to be the defacto comment character
syn match knownHostsComment '^#.*$'

hi def link knownHostsIdentity Function
hi def link knownHostsKeyTypeWrapper Error
hi def link knownHostsKeyType Keyword
hi def link knownHostsComment Comment

let b:current_syntax = "known_hosts"
