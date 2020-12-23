function! gggoload#loadplugin abort
    " let g:plugin_config = [{'module': 'github.com/knsh14/githublink', 'version': 'latest', 'command': 'githublink'}]
    let l:plugin_configs = get(g:, 'plugin_config', '')

    for i in g:plugin_config
        let c = 'go get '.get(i, 'module', '').'@'.get(i, 'version', 'latest')
        echo c
        call system(c)
    endfor

    let output = []
    for i in g:plugin_config
        let commandname = get(i, 'command', '')
        call add(output,printf("function! s:Job%sStart(host) abort", commandname))
        call add(output,printf("  return jobstart('%s', { 'rpc': v:true })", commandname))
        call add(output,"endfunction")
        call add(output, printf("call remote#host#Register('%s', 'x', function('s:Job%sStart'))", commandname, commandname))
        let c = commandname.' -manifest '.commandname
        echo c
        let v = system(c)
        let v2 = substitute(v, '\\', '', "g")
        call add(output, substitute(v2, '\n', '', "g"))
    endfor
    let s:fpath = expand('<sfile>:p:h').'/gopluins.vim'
    call writefile(output, s:fpath)
    source s:fpath
endfunction
