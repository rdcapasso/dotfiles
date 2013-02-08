set runtimepath+=~/.vim_runtime
"let loaded_yankring = 1

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry
au BufWinEnter *.txt if &ft == 'help' | if &columns > 156 | wincmd H | else | wincmd J | endif | endif
" Fix some command typing mistakes
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" my own shit
ca vr vertical resize


" Search mappings:  These will make it so that going to the next one in a
" search will center the line it's found in.
nmap N Nzz
nmap n nzz
xmap N Nzz
xmap n nzz

" Always set Very Magic when searching
nnoremap / /\v
vnoremap / /\v

let g:NERDTreeChDirMode=2
"let g:Powerline_symbols = 'fancy'
set number
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd VimEnter * TagbarToggle
