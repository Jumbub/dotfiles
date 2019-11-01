set nocompatible " Dont bother pretending to be old

vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

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
let g:fzf_files_options = '--tiebreak=end'

Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-smooth-scroll'


Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen = 1
Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
let g:prosession_dir = '/home/jamie/workspaces/vim/'
Plug 'lambdalisue/suda.vim'

Plug 'wakatime/vim-wakatime'

" THEME
Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'sickill/vim-monokai'
"Plug 'jaromero/vim-monokai-refined'
"Plug 'crusoexia/vim-monokai'
Plug 'ryanoasis/vim-devicons'

" IDE
"Plug 'Quramy/tsuquyomi' " Completions, symbols
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-vimlsp' ]
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'

"Plug 'adimit/prolog.vim'

" SYNTAX HIGHLIGHTING
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tbastos/vim-lua'
Plug 'StanAngeloff/php.vim'

call plug#end()
syntax on
colorscheme sublimemonokai
set termguicolors
set undofile
set signcolumn=yes
set undodir=~/.vim/undodir
"let g:sublimemonokai_term_italic = 1
:set number relativenumber

" Event Bindings "
autocmd BufWritePre *.tsx,*.ts undojoin | Neoformat
let g:neoformat_only_msg_on_error = 1

" File Naming "
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
autocmd BufRead,BufWritePost,BufNewFile *.tsx setlocal syntax=javascript.jsx

command Tf CocCommand tsserver.executeAutofix
command Ti CocCommand tsserver.organizeImports

"CocConfig ~/.config/nvim/coc-settings.json

" Key Bindings "
nmap <C-A-p> :call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR><CR>
nmap <leader>r :! cd %:p:h &&
nnoremap <silent> <expr> <A-p> g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

nmap <C-l> i\HE\Util\Logger::Logger('DEBUGGING')->emergency('xxx', [ xxx ]);<Esc>?xxx<CR>nve<C-n>c
nmap <C-p> :Files<CR>
nmap <C-f> :BLines<CR>
nmap <C-r> :CocList outline<cr>
nmap <C-R> :CocList -I symbols<CR>
noremap <silent> <C-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
noremap <silent> <C-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map ,r :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>acd $VIM_DIR<CR>

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
