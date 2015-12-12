"=============================================================================
" vim-silentshout - Just shout silently in Twitter from Vim
" Copyright (c) 2013 Scheakur <http://scheakur.com/>
" License: MIT license
"=============================================================================

if exists('g:loaded_silentshout')
	finish
endif
let g:loaded_silentshout = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=? SilentShout call s:silentshout(<q-args>)

function! s:silentshout(args)
	if silentshout#shout(a:args)
		redraw!
	endif
endfunction

nnoremap <silent> <Plug>(silentshout)  :<C-u>SilentShout<CR>


let &cpo = s:save_cpo
unlet s:save_cpo
