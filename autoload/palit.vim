function! palit#preview(palette, mode) abort
  execute a:mode
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal bufhidden=hide
  setlocal nobuflisted
  setlocal conceallevel=3

  let l:palette = eval(a:palette)
  let l:colors = sort(filter(keys(l:palette), 'v:val !=# "none"'))
  let l:line = join(l:colors, ' ')
  for l:bg in reverse(l:colors)
    call append(0, '_' . l:bg . ' ' . l:line)
    let l:bg_grp = 'Palit' . l:bg
    execute printf(
      \ 'hi %s ctermbg=%s guibg=%s',
      \ l:bg_grp,
      \ l:palette[l:bg].term,
      \ l:palette[l:bg].gui)
    call matchaddpos(l:bg_grp, [len(l:colors) - line('$') + 2], 9)

    for l:fg in l:colors
      let l:grp = 'Palit' . l:fg . l:bg
      execute printf(
        \ 'hi %s ctermfg=%s ctermbg=%s guifg=%s guibg=%s',
        \ l:grp,
        \ l:palette[l:fg].term,
        \ l:palette[l:bg].term,
        \ l:palette[l:fg].gui,
        \ l:palette[l:bg].gui)
      call matchadd(l:grp, printf('^_%s.*\zs\<%s\>', l:bg, l:fg))
    endfor
  endfor
  call matchadd('Conceal', '^_\S\+\s\+')
endfunction
