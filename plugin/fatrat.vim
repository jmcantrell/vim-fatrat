if exists('g:fatrat_loaded')
    finish
endif
let g:fatrat_loaded = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

command! -bar -nargs=? -complete=filetype FatRatEdit :call s:EditScripts(<q-args>)
command! -bar -nargs=? -complete=filetype FatRatList :call s:ListScripts(<q-args>)

function! s:EditScripts(type)
    for script in s:GetScripts(a:type)
        execute 'edit ' . script
    endfor
endfunction

function! s:ListScripts(type)
    for script in s:GetScripts(a:type)
        echo script
    endfor
endfunction

function! s:GetScripts(type)
    let filetype = a:type
    if len(filetype) == 0
        let filetype = &filetype
    endif
    let scripts = []
    if len(filetype) > 0
        for dir in ['ftplugin', 'syntax', 'indent']
            for suffix in ['.vim', '/*.vim', '_*.vim']
                call extend(scripts, s:GetFiles(dir . '/' . filetype . suffix))
            endfor
        endfor
    endif
    return scripts
endfunction

function! s:GetFiles(pattern)
    return split(globpath(&runtimepath, a:pattern), '\n')
endfunction

let &cpoptions = s:save_cpoptions
