if &compatible
    set compatible
endif

function! s:resolve_path(path)
    let abspath = resolve(expand('$HOME/.vim/' . a:path))
    return abspath
endfunction

function! s:source_rc(path)
    let abspath = s:resolve_path(a:path . '.rc.vim')
    execute 'source' abspath
endfunction

syntax enable
filetype plugin indent on

call s:source_rc('encodings')
call s:source_rc('options')
call s:source_rc('mappings')
call s:source_rc('filetypes')
