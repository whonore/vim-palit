function! palit#preview(palette, mode) abort
  execute a:mode
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal conceallevel=3

  let l:palette = eval(a:palette)
  let l:colors = sort(filter(keys(l:palette), 'v:val !=# "none"'))
  for l:bg in l:colors
    call append(0, '_' . l:bg . ' ' . join(l:colors, ' '))
    for l:fg in l:colors
      execute printf(
        \ 'hi Palit%s%s ctermfg=%s ctermbg=%s guifg=%s guibg=%s',
        \ l:fg,
        \ l:bg,
        \ l:palette[l:fg].term,
        \ l:palette[l:bg].term,
        \ l:palette[l:fg].gui,
        \ l:palette[l:bg].gui)
      call matchadd(
        \ printf('Palit%s%s', l:fg, l:bg),
        \ printf('^_%s.*\zs\<%s\>', l:bg, l:fg))
    endfor
  endfor
  call matchadd('Conceal', '^_\S\+')
endfunction
