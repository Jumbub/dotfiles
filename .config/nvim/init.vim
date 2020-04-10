" NeoVim Config

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " Install plugin manager if not already installed
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged') " Setup plugin manager install directory

Plug 'crusoexia/vim-monokai' " Colour scheme
Plug 'StanAngeloff/php.vim'
Plug 'airblade/vim-gitgutter' " Inline git line statuses
Plug 'editorconfig/editorconfig-vim' " Format definitions
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim' " Install fzf for vim
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Library for IDE tooling
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons' " Icons for directory tree
Plug 'sbdchd/neoformat' " Auto formatter
Plug 'scrooloose/nerdtree' " Directory tree
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'tbastos/vim-lua'
Plug 'terryma/vim-smooth-scroll' " Smooth scrolling
Plug 'tpope/vim-commentary' " Quick comments
Plug 'tpope/vim-eunuch' " File helpers
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Word wapping
Plug 'tpope/vim-abolish' " Word modifiation
Plug 'wakatime/vim-wakatime' " Track development time
Plug 'tpope/vim-obsession' " Session management
Plug 'dhruvasagar/vim-prosession' " Better session management
Plug 'terryma/vim-multiple-cursors' " Multi cursor
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Markdown preview
Plug 'jparise/vim-graphql'
" Plug 'easymotion/vim-easymotion' " Add quick movement using motions
" Plug 'lambdalisue/suda.vim' " Write files with sudo
" Plug 'Quramy/tsuquyomi' " Completions, symbols
" Plug 'adimit/prolog.vim'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'peitalin/vim-jsx-typescript'

call plug#end() " Finish setting up plugins

" File formatting
autocmd BufWritePre *.tsx,*.ts,*.py,*.php Neoformat
" Codejams
autocmd BufWritePost sol.js silent! !./build &
autocmd BufWritePost in silent! !./build &
" Compton autoreload config changes
autocmd BufWritePost compton.conf silent! !pkill -USR1 compton

" autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript " Override ts filetype
" autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx " Override tsx filetype
" autocmd BufNewFile,BufRead *.tsx setlocal syntax=javascript.jsx " Override tsx syntax

colorscheme monokai " Set colour scheme
filetype plugin on " Detect the current file
syntax on " Enable syntax highlighting
let g:NERDTreeQuitOnOpen = 1 " Close tree on opening a file
let g:NERDTreeWinSize = 60 " Size of frame
let g:coc_global_extensions = ['coc-marketplace'] " IDE tooling
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_php = ['phpcbf']
let g:neoformat_only_msg_on_error = 1 " Throw error on failed formatting
let g:prosession_dir = '/home/jamie/workspaces/vim/' " Set the directory to create prosessions
let g:mkdp_auto_close = 1
let mapleader = "," " Map the leader key
set clipboard=unnamedplus " Share clipboard with system
set cmdheight=2 " Avoid the 'hit enter' prompt caused by multi line commands
set nocompatible " Dont bother pretending to be old
set noswapfile " Don't bother using swap files
set number relativenumber " Use relative line numbers
set signcolumn=yes " Always display gutter (prevent git gutter from bouncing on save)
set termguicolors " Use terminal colours
set undodir=~/.vim/undodir " Set undo history file
set undofile " Persist undo history between sessions
highlight Search gui=underline guibg=#484943


imap <silent><expr> <c-space> coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <silent><expr> <c-space> coc#refresh()
nmap / /\c
nmap <leader>D :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>acd $VIM_DIR<CR>
nmap <leader>a <Plug>(coc-codeaction)
nmap <leader>c :CocCommand<CR>
nmap <leader>d :let $VIM_DIR=expand('%:h')<CR>:terminal<CR>acd $VIM_DIR<CR>
nmap <leader>gc gg/scss<CR>gf
nmap <leader>r <Plug>(coc-rename)
nmap <silent> <leader>f <Plug>(coc-fix-current)
nmap <silent> U :redo<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <C-l> i\HE\Util\Logger::Logger(\HE\Logging\LogChannel::DEBUGGING())->emergency('xxx', [ ]);<Esc>?xxx<CR>nve
nnoremap <C-p> :Files<CR>
nnoremap <leader>go :call GoogleSearchPhrase()
nnoremap <leader>j :Rg <CR>
nnoremap <leader>siw "syiw:F <C-r>s<CR>
nnoremap <leader>ss :F  <backspace>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
nnoremap <silent> <expr> <leader>m g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <leader>p :call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR>
nnoremap <silent> <leader><leader>p :Restart<CR>
nnoremap <silent> <leader>vp :Prosession ~/workspaces/vim/%home%jamie%.config%nvim.vim<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nnoremap gS :CocList outline<cr>
nnoremap gs :CocList -I symbols<CR>
vmap <leader>a <Plug>(coc-codeaction-selected)
vmap <leader>gc ygg/scss<CR>gf/<C-r>0<CR>
vmap <leader>wb "wy:read !<C-r>w<CR>
vmap <leader>wpy "wy:read !python -c "<C-r>w"<CR>
vmap <silent> af <Plug>(coc-range-select)
vnoremap <leader>go "gy<Esc>:call GoogleSearch()<CR>
vnoremap <leader>j "sy:Rg <C-r>s<CR>

command! FF Neoformat
command! Restart call <sid>vim_quit_and_restart()

function! GoogleSearchPhrase(term) " Run a google search
  silent! exec "silent! !google-chrome \"https://google.com/search?q=" . a:term . "\" &"
endfunction

function! GoogleSearch() " Run a google search for the selection in the g registry
  let term = getreg("g")
  call GoogleSearchPhrase(term)
endfunction

function! NearbyFiles() " Run a google search for the selection in the g registry
  let location = expand('%:p:h')
  exec "Files " . location
endfunction
nnoremap <leader>e :call NearbyFiles()<CR>

" Restart vim (requires the following setup)
" ```sh
" trap __catch_signal_usr1 USR1
" __catch_signal_usr1() { trap __catch_signal_usr1 USR1; vim; }
" ```
function! s:vim_quit_and_restart() abort
  if (&mod)
    echo "Warning: cannot restart nvim when there are changes."
  else
    sil call system('kill -USR1 $(ps -p '.getpid().' -o ppid=)')
    qa!
  endif
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


