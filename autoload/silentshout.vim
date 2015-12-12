"=============================================================================
" vim-silentshout - Just shout silently in Twitter from Vim
" Copyright (c) 2013 Scheakur <http://scheakur.com/>
" License: MIT license
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

let s:cmd = get(g:, 'silentshout_command', 'silentshout')

function! silentshout#shout(text)
	if !executable(s:cmd)
		call s:show_error()
		return 0
	endif

	if empty(a:text)
		call winput#open('silentshout', function('s:write'), {
		\	'win_height': 3,
		\	'on_validate': function('s:validate'),
		\})
		return 0
	endif

	call s:write(a:text)
	return 1
endfunction


" internal functions {{{
function! s:show_error()
	echohl Error
	echomsg 'silentshout.vim needs `silentshout` command.'
	echomsg 'Installation:'
	echomsg '> go get github.com/scheakur/silentshout'
	echohl None
endfunction


function! s:write(text)
	call system(s:cmd . ' ' . winput#escape(a:text) . ' &')
endfunction


function! s:validate(text, bang)
	if a:bang
		return [1, 'OK']
	endif
	let len = strchars(a:text)
	if len > 141 
		let msg = 'Message is too long (over 140 chars): ' . len
		return [0, msg]
	endif
	return [1, 'OK']
endfunction
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo

