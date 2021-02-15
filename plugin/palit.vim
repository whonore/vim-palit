if exists('g:loaded_palit')
  finish
endif
let g:loaded_palit = 1

command! -nargs=1 -complete=expression Palit call palit#preview(<q-args>, 'enew')
command! -nargs=1 -complete=expression SPalit call palit#preview(<q-args>, 'new')
command! -nargs=1 -complete=expression VPalit call palit#preview(<q-args>, 'vnew')
