if exists('g:loaded_gggoload')
  finish
endif
let g:loaded_gggoload = 1
" let g:plugin_config = [{'module': 'github.com/knsh14/foo', 'version': 'latest', 'command': 'foo'}]

call gggoload#loadplugin()
