" NeoVim Config

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " Install plugin manager if not already installed
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged') " Setup plugin manager install directory

" Plug 'StanAngeloff/php.vim' " Improved syntax highlighting
" Plug 'chamindra/marvim' " Saving macros permanently
" Plug 'crusoexia/vim-monokai' " Colour scheme
" Plug 'erichdongubler/vim-sublime-monokai' " Colour scheme
" Plug 'leafgarland/typescript-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Library for IDE tooling
" Plug 'pangloss/vim-javascript'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'tbastos/vim-lua' " Improved syntax highlighting
Plug 'Iron-E/nvim-highlite' " Colour scheme
Plug 'airblade/vim-gitgutter' " Inline git line statuses
Plug 'editorconfig/editorconfig-vim' " Format definitions
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Markdown preview
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim' " Install fzf for vim
Plug 'nvim-treesitter/nvim-treesitter' " Semantic syntax highlighting
Plug 'nvim-treesitter/playground' " Show syntax tree for debugging
Plug 'sbdchd/neoformat' " Auto formatter
Plug 'scrooloose/nerdtree' " Directory tree
Plug 'terryma/vim-smooth-scroll' " Smooth scrolling
Plug 'tpope/vim-abolish' " Word modifiation
Plug 'tpope/vim-commentary' " Quick comments
Plug 'tpope/vim-eunuch' " File helpers
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Word wapping
Plug 'wakatime/vim-wakatime' " Track development time
Plug 'norcalli/nvim-colorizer.lua' " Inline colour code highlighting

" Order matters for the following plugins
Plug 'tpope/vim-obsession' " Session management
Plug 'dhruvasagar/vim-prosession' " Better session management

call plug#end() " Finish setting up plugins

" File formatting
autocmd BufWritePre *.tsx,*.ts,*.py Neoformat

" Compton autoreload config changes
autocmd BufWritePost compton.conf silent! !pkill -USR1 compton

set clipboard=unnamedplus " Share clipboard with system
set cmdheight=2 " Avoid the 'hit enter' prompt caused by multi line commands
set nocompatible " Dont bother pretending to be old
set noswapfile " Don't bother using swap files
set number relativenumber " Use relative line numbers
set signcolumn=yes " Always display gutter (prevent git gutter from bouncing on save)
set termguicolors " Use terminal colours
set undodir=~/.vim/undodir " Set undo history file
set undofile " Persist undo history between sessions

let g:NERDTreeQuitOnOpen = 1 " Close tree on opening a file
let g:NERDTreeWinSize = 60 " Size of frame
" let g:coc_global_extensions = ['coc-marketplace'] " IDE tooling
let g:marvim_find_key = ',@' " Find macro
let g:marvim_store = '/home/jamie/.config/nvim/macros' " Set store location
let g:marvim_store_key = ',q' " Save macro
let g:mkdp_auto_close = 1
let g:neoformat_enabled_php = ['phpcbf']
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_only_msg_on_error = 1 " Throw error on failed formatting
let g:prosession_dir = '/home/jamie/workspaces/vim/' " Set the directory to create prosessions
let mapleader = "," " Map the leader key

lua << EOF
require'colorizer'.setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "c", "rust" },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}
EOF

filetype plugin on " Detect the current file
syntax on " Enable syntax highlighting

set rtp+=/home/jamie/repos/monokai-ts " Local colour scheme
colorscheme monokai_ts " Set colour scheme

" Highlight using background rather then underline
highlight Search gui=none guibg=#484943

" Goto file in git status
" nnoremap <leader>vs :let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name')<CR>
" imap <silent><expr> <c-space> coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
" inoremap <silent><expr> <c-space> coc#refresh()
nmap / /\c
" nmap <leader>D :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>acd $VIM_DIR<CR>
" nmap <leader>a <Plug>(coc-codeaction)
" nmap <leader>c :CocCommand<CR>
" nmap <leader>d :let $VIM_DIR=expand('%:h')<CR>:terminal<CR>acd $VIM_DIR<CR>
" nmap <leader>gc gg/scss<CR>gf
" nmap <leader>r <Plug>(coc-rename)
" nmap <silent> <leader>f <Plug>(coc-fix-current)
nmap <silent> U :redo<CR>
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gr <Plug>(coc-references)
nmap ? ?\c
" nnoremap <C-l> i\HE\Util\Logger::Logger(\HE\Logging\LogChannel::DEBUGGING())->emergency('asdffdsa', [ ]);<Esc>?asdffdsa<CR>nve
nnoremap <C-p> :Files<CR>
nnoremap <leader><C-p> :call fzf#run({'source': 'git status --short \| rg -o "\S*$"', 'sink': 'e', 'down': '10', 'options': '--tiebreak=end'})<CR>
nnoremap <leader>j :Rg <CR>
nnoremap <leader>siw "syiw:F <C-r>s<CR>
nnoremap <leader>ss :F  <backspace>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 5, 1)<CR>
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 5, 1)<CR>
nnoremap <silent> <expr> <leader>m bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
nnoremap <silent> <leader><leader>p :Restart<CR>
nnoremap <silent> <leader>p :call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR>
nnoremap <silent> <leader>p :call fzf#run({'source': 'find ~/workspaces/vim/*', 'sink': 'Prosession', 'down': '10', 'options': '--tiebreak=end'})<CR>
nnoremap <silent> <leader>vp :Prosession ~/workspaces/vim/%home%jamie%.config%nvim.vim<CR>
" nnoremap <silent> gh :call <SID>show_documentation()<CR>
" nnoremap gS :CocList outline<cr>
" nnoremap gs :CocList -I symbols<CR>
vmap / /\c
" vmap <leader>a <Plug>(coc-codeaction-selected)
vmap <leader>c yq/p<CR>Ncgn
vmap <leader>gc ygg/scss<CR>gf/<C-r>0<CR>
vmap <leader>wb "wy:read !<C-r>w<CR>
vmap <leader>wpy "wy:read !python -c "<C-r>w"<CR>
" vmap <silent> af <Plug>(coc-range-select)
vmap ? ?\c
vnoremap <leader>go "gy<Esc>:call GoogleSearch()<CR>
vnoremap <leader>j "sy:Rg <C-r>s<CR>

command! FF Neoformat
command! GC Rg <<<<<<< HEAD " Find git conflicts
command! Restart call <sid>vim_quit_and_restart() " Restart vim

function! GoogleSearchPhrase(term) " Run a google search
  silent! exec "silent! !google-chrome-stable \"https://google.com/search?q=" . a:term . "\" &"
endfunction

function! GoogleSearch() " Run a google search for the selection in the g registry
  let term = getreg("g")
  call GoogleSearchPhrase(term)
endfunction

function! NearbyFiles() " Get files in nearby radius
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
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Wrap code in PHP tag symbol from char2nr('-')
" let b:surround_45 = "<?php \r ?>"

" Automatically assign some arbitrary file types
autocmd BufEnter .babelrc :setlocal filetype=json

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
map <leader>y :call SynStack()<CR>
