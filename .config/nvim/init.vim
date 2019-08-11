set nocompatible " Dont bother pretending to be old

"Plugins"

filetype plugin on " Built in plugin

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" fzf functionality showcase https://www.youtube.com/watch?v=aXPQTesFdTI
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'

Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'HerringtonDarkholme/yats.vim'

" LANGUAGE SPECIFICS

" .jsx,.tsx
Plug 'peitalin/vim-jsx-typescript' " Syntax highlighting

" .ts
"Plug 'Quramy/tsuquyomi' " Completions, symbols
Plug 'leafgarland/typescript-vim' " Syntax highlighting

call plug#end()

" Color Scheme "

syntax on
colorsche sublimemonokai

set termguicolors

let g:sublimemonokai_term_italic = 1

" If colours aren't perfect check these docs, there are extra configurations
" https://github.com/ErichDonGubler/vim-sublime-monokai

" Keybindings "
nmap <C-p> :Files<CR>
nmap <C-r> :BTags<CR>
nmap <C-R> :Tags<CR>
nmap <C-f> :BLines<CR>
