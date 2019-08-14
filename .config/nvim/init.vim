set nocompatible " Dont bother pretending to be old

"Plugins"

filetype plugin on " Built in plugin

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf functionality showcase https://www.youtube.com/watch?v=aXPQTesFdTI
Plug 'junegunn/fzf.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'

Plug 'scrooloose/nerdtree'

" THEME
Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'sickill/vim-monokai'
"Plug 'jaromero/vim-monokai-refined'
"Plug 'crusoexia/vim-monokai'
Plug 'ryanoasis/vim-devicons'

" IDE
"Plug 'Quramy/tsuquyomi' " Completions, symbols
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json' ]

" SYNTAX HIGHLIGHTING
"Plug 'leafgarland/typescript-vim' " Syntax highlighting
"Plug 'pangloss/vim-javascript'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'pangloss/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'

call plug#end()

" Theme "
syntax on
colorscheme sublimemonokai
set termguicolors
"let g:sublimemonokai_term_italic = 1
:set number relativenumber

" Event Bindings "
autocmd BufWritePre * undojoin | Neoformat

" File Naming "
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
autocmd BufRead,BufNewFile *.tsx setlocal syntax=javascript.jsx

" Key Bindings "
nmap <C-A-p> :call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'source', 'down': '10'})<CR>

nmap <C-p> :Files<CR>
nmap <C-r> :BTags<CR>
nmap <C-R> :Tags<CR>
nmap <C-f> :BLines<CR>

nmap <A-p> :NERDTreeToggle<CR>

nmap <silent> gd <Plug>(coc-definition)

" CoC completions on tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
