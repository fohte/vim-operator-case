function! operator#case#snakenize(motion_wiseness)
  let l:text = s:cut_textobj(a:motion_wiseness)
  let l:text = s:snakenize(l:text)
  call s:paste(l:text)
endfunction

function! operator#case#constantize(motion_wiseness)
  let l:text = s:cut_textobj(a:motion_wiseness)
  let l:text = s:constantize(l:text)
  call s:paste(l:text)
endfunction

function! operator#case#pascalize(motion_wiseness)
  let l:text = s:cut_textobj(a:motion_wiseness)
  let l:text = s:pascalize(l:text)
  call s:paste(l:text)
endfunction

function! operator#case#camelize(motion_wiseness)
  let l:text = s:cut_textobj(a:motion_wiseness)
  let l:text = s:camelize(l:text)
  call s:paste(l:text)
endfunction

function! s:cut_textobj(motion_wiseness)
  let l:visual_command =
    \ operator#user#visual_command_from_wise_name(a:motion_wiseness)
  let l:register_name = operator#user#register()
  let l:tmp_reg = getreg(l:register_name)

  let l:reg_value = ''

  try
    let l:old_selection = &g:selection
    let &g:selection = 'inclusive'
    execute 'normal!' '`[' . l:visual_command . '`]"' . l:register_name . 'd'
    let &g:selection = l:old_selection
    let l:reg_value = getreg(l:register_name)
  finall
    call setreg(l:register_name, l:tmp_reg)
  endtry

  return l:reg_value
endfunction

function! s:paste(text)
  let l:register_name = operator#user#register()
  let l:tmp_reg = getreg(l:register_name)
  call setreg(l:register_name, a:text)

  try
    execute 'normal!' '"' . l:register_name . 'P'
  finally
    call setreg(l:register_name, l:tmp_reg)
  endtry
endfunction

function! s:snakenize(text)
  let l:text = a:text
  let l:text = substitute(l:text, '\([A-Z]\+\)\([A-Z][a-z]\)', '\1_\2', 'g')
  let l:text = substitute(l:text, '\([a-z]\)\([A-Z]\)', '\1_\2', 'g')
  let l:text = tolower(l:text)
  return l:text
endfunction

function! s:constantize(text)
  return toupper(s:snakenize(a:text))
endfunction

function! s:camelize(text)
  return substitute(s:snakenize(a:text), '\(.\)_\(.\)', '\l\1\u\2', 'g')
endfunction

function! s:pascalize(text)
  let l:text = s:camelize(a:text)
  let l:text = toupper(l:text[0]) . l:text[1:]
  return l:text
endfunction
