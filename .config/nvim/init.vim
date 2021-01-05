" NeoVim Config

let nvim_native_lsp = 0 " Native NVIM LSP toggle
let nvim_native_ts = 1 " Native NVIM Tree-sitter toggle
let nvim_coc = 1 " Native NVIM CoC toggle
let nvim = has('nvim') " Using NVIM
let vim = !has('nvim') " Using VIM

filetype plugin on " Detect the current file
syntax on " Enable syntax highlighting

if nvim
  set inccommand=split " Show substitude command effects as you type
endif
if nvim_native_lsp
  set shortmess+=c " Avoid showing message extra message when using completion (completion-nvim)
endif
set clipboard=unnamedplus " Share clipboard with system
set cmdheight=2 " Avoid the 'hit enter' prompt caused by multi line commands
set nocompatible " Dont bother pretending to be old
set noswapfile " Don't bother using swap files
set number relativenumber " Use relative line numbers
set signcolumn=yes " Always display gutter (prevent git gutter from bouncing on save)
set termguicolors " Use terminal colours
set undodir=~/.vim/undodir " Set undo history file
set undofile " Persist undo history between sessions
set completeopt=menuone,noinsert,noselect " Set completeopt to have a better completion experience (completion-nvim)

let mapleader = "," " Map the leader key

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " Install plugin manager if not already installed
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged') " Setup plugin manager install directory

Plug 'Iron-E/nvim-highlite' " Colour scheme
Plug 'airblade/vim-gitgutter' " Inline git line statuses
Plug 'editorconfig/editorconfig-vim' " Format definitions
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Markdown preview
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim' " Install fzf for vim
Plug 'norcalli/nvim-colorizer.lua' " Inline colour code highlighting
Plug 'nvim-lua/completion-nvim' " Auto-complete plugin
Plug 'patstockwell/vim-monokai-tasty' " Monokai theme
Plug 'sbdchd/neoformat' " Auto formatter
Plug 'scrooloose/nerdtree' " Directory tree
Plug 'sheerun/vim-polyglot' " A bunch of syntax packs
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'terryma/vim-smooth-scroll' " Smooth scrolling
Plug 'tpope/vim-abolish' " Word modifiation
Plug 'tpope/vim-commentary' " Quick comments
Plug 'tpope/vim-eunuch' " File helpers
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Word wapping
Plug 'wakatime/vim-wakatime' " Track development time

" Order matters for the following plugins
Plug 'tpope/vim-obsession' " Session management
Plug 'dhruvasagar/vim-prosession' " Better session management

" Optional plugins
if nvim_native_lsp
  Plug 'neovim/nvim-lspconfig' " NeoVim LSP plugin
endif
if nvim_native_ts
  Plug 'nvim-treesitter/nvim-treesitter' " Semantic syntax highlighting
endif
if nvim_coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC IDE
endif
if vim
  " Recommended by vim-monokai-tasty
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'styled-components/vim-styled-components'
  Plug 'elzr/vim-json'
  Plug 'jparise/vim-graphql'
endif

call plug#end() " Finish setting up plugins

let g:NERDTreeQuitOnOpen = 1 " Close tree on opening a file
let g:NERDTreeWinSize = 60 " Size of frame
let g:marvim_find_key = ',@' " Find macro
let g:marvim_store = '/home/jamie/.config/nvim/macros' " Set store location
let g:marvim_store_key = ',q' " Save macro
let g:mkdp_auto_close = 1
let g:neoformat_enabled_php = ['phpcbf']
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_only_msg_on_error = 1 " Throw error on failed formatting
let g:prosession_dir = '/home/jamie/workspaces/vim/' " Set the directory to create prosessions

" Goto file in git status
nmap / /\c
nmap <leader>y :What<CR>
nmap <silent> U :redo<CR>
nmap ? ?\c
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
vmap / /\c
vmap <leader>c yq/p<CR>Ncgn
vmap <leader>gc ygg/scss<CR>gf/<C-r>0<CR>
vmap <leader>wb "wy:read !<C-r>w<CR>
vmap <leader>wpy "wy:read !python -c "<C-r>w"<CR>
vmap ? ?\c
vnoremap <leader>go "gy<Esc>:call GoogleSearch()<CR>
vnoremap <leader>j "sy:Rg <C-r>s<CR>

if nvim_native_lsp
  nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> gS <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> gs <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
endif
if nvim_coc
  imap <silent><expr> <c-space> coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  inoremap <silent><expr> <c-space> coc#refresh()
  nmap <leader>a <Plug>(coc-codeaction)
  nmap <leader>c :CocCommand<CR>
  nmap <leader>r <Plug>(coc-rename)
  nmap <silent> <leader>f <Plug>(coc-fix-current)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> gh :call <SID>show_documentation()<CR>
  nnoremap gS :CocList outline<cr>
  nnoremap gs :CocList -I symbols<CR>
  vmap <leader>a <Plug>(coc-codeaction-selected)
  vmap <silent> af <Plug>(coc-range-select)

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
endif

let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_auto_popup = 0

imap <silent> <c-space> <Plug>(completion_trigger)

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

command! FF Neoformat " Format file
command! GC Rg <<<<<<< HEAD " Find git conflicts
command! Restart call <sid>vim_quit_and_restart() " Restart vim

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction

command What :exec "call SynStack() \n TSHighlightCapturesUnderCursor"

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

if vim
  let g:vim_monokai_tasty_italic = 1
  colorscheme vim-monokai-tasty " Set theme
endif

if nvim
  set rtp+=~/.config/nvim/nvim-monokai " Local colour scheme
  colorscheme nvim_monokai " Set theme
endif

" File formatting
autocmd BufWritePre *.tsx,*.ts,*.py,*.html Neoformat

" Picom autoreload config changes
autocmd BufWritePost picom.conf !pkill -USR1 picom || (picom &)

" Automatically assign some arbitrary file types
autocmd BufEnter .babelrc :setlocal filetype=json

" Ensure syntax highlighting is deterministic
" autocmd BufWritePost * :syntax sync fromstart

" Test awesome window manager
autocmd BufWritePost /home/jamie/.config/awesome/* !/home/jamie/scripts/testWindowManager.sh

if nvim
  " The color scheme is calculated at runtime
  lua require'colorizer'.setup()
endif

if nvim_native_ts
  " Native NVIM Tree sitter setup
  lua require'nvim-treesitter.configs'.setup { ensure_installed = "maintained", highlight = { enable = true } };
endif

if nvim_native_lsp
  " Typescript
  lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
  " PHP
  lua require'lspconfig'.intelephense.setup{ on_attach=require'completion'.on_attach }
  " C/C++
  lua require'lspconfig'.ccls.setup{ on_attach=require'completion'.on_attach }
endif

set statusline=%<%f\  " Left side
set statusline+=\ %h%m%r%=%(%l,%c%V%)  " Right side
