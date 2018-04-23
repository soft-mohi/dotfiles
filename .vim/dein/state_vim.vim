if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/moriwaki/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/moriwaki/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim80,/usr/local/share/vim/vimfiles/after,/Users/moriwaki/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/moriwaki/.vimrc', '/Users/moriwaki/.vim/dein/dein.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/moriwaki/.vim/dein'
let g:dein#_runtime_path = '/Users/moriwaki/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/moriwaki/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/moriwaki/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/moriwaki/.vim,/usr/local/share/vim/vimfiles,/Users/moriwaki/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vim80,/Users/moriwaki/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/moriwaki/.vim/after'
