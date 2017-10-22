if exists('g:loaded_operator_case')
  finish
endif

call operator#user#define('case-snakenize', 'operator#case#snakenize')
call operator#user#define('case-constantize', 'operator#case#constantize')
call operator#user#define('case-pascalize', 'operator#case#pascalize')
call operator#user#define('case-camelize', 'operator#case#camelize')

let g:loaded_operator_case = 1
