"Plugins"

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

call plug#end()

" Color Scheme "

syntax on
colorsche sublimemonokai

set termguicolors

let g:sublimemonokai_term_italic = 1

" If colours aren't perfect check these docs, there are extra configurations
" https://github.com/ErichDonGubler/vim-sublime-monokai
