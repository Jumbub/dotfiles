" NeoVim Config

let nvim = has('nvim') " Using NVIM
let nvim_native_lsp = 0 && nvim " Native NVIM LSP toggle
let nvim_native_ts = 0 && nvim " Native NVIM Tree-sitter toggle
let nvim_coc = 1 && nvim " Native NVIM CoC toggle

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
set statusline=%<%f\  " Left side
set statusline+=\ %h%m%r%=%(%l,%c%V%)  " Right side
set updatetime=300 " CursorHold activation time

let mapleader = "," " Map the leader key

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " Install plugin manager if not already installed
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged') " Setup plugin manager install directory

" Plug 'puremourning/vimspector' " Debug Inspector
" Plug 'szw/vim-maximizer' " Maximising windows (primarily for vimspector)
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'editorconfig/editorconfig-vim' " Format definitions
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Markdown preview
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Install fzf
Plug 'junegunn/fzf.vim' " Install fzf for vim
Plug 'mhinz/vim-signify' " Inline git line statuses
Plug 'sbdchd/neoformat' " Auto formatter
Plug 'scrooloose/nerdtree' " Directory tree
Plug 'terryma/vim-smooth-scroll' " Smooth scrolling
Plug 'dhruvasagar/vim-open-url' " Open URL in browser
Plug 'tpope/vim-abolish' " Word modifiation
Plug 'tpope/vim-commentary' " Quick comments
Plug 'tpope/vim-eunuch' " File helpers
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Word wapping
Plug 'wakatime/vim-wakatime' " Track development time
" TODO: remove specific commit when the main channel is fixed
Plug 'rktjmp/lush.nvim', {'commit': '9f720e13b3aa21eb28d4ac369f4408c68bfea266'} " Creating colour schemes
Plug 'jupyter-vim/jupyter-vim' " Python testing
Plug 'udalov/kotlin-vim' " Kotlin syntax highlighting

" Order matters for the following plugins
Plug 'tpope/vim-obsession' " Session management
Plug 'dhruvasagar/vim-prosession' " Better session management

" Optional plugins
if nvim
  Plug 'nvim-lua/completion-nvim' " Auto-complete plugin
  Plug 'norcalli/nvim-colorizer.lua' " Inline colour code highlighting
endif
if nvim_native_lsp
  Plug 'RishabhRD/popfix' " Required for nvim-lsputils
  Plug 'RishabhRD/nvim-lsputils' " Make neovim-lsp more CoC like
  Plug 'neovim/nvim-lspconfig' " NeoVim LSP plugin
endif
if nvim_native_ts
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Semantic syntax highlighting
  Plug 'nvim-treesitter/playground' " Debugging syntax highlighting
endif
if nvim_coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " CoC IDE
endif

call plug#end() " Finish setting up plugins

let g:open_url_browser_default = 'google-chrome-stable' " Open URL browser
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
let g:completion_enable_auto_popup=1 " Live auto-complete
let g:completion_confirm_key = "\<C-y>"
let g:completion_enable_auto_popup=1
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '~'
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line


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
nnoremap <leader>F :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>dq :call vimspector#Reset()<CR>
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nmap <leader>dl <Plug>VimspectorStepOver
nmap <leader>dj <Plug>VimspectorStepInto
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dh <Plug>VimspectorRestart
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
nmap <C-k> :cp<CR>
nmap <C-j> :cn<CR>
nmap <C-h> :cclose<CR>
nmap <C-l> :copen<CR>
nmap <leader>r :JupyterSendCell<CR>
vmap <leader>r :JupyterRunVisual<CR>

if nvim
  imap <silent> <c-space> <Plug>(completion_trigger)
  imap <tab> <Plug>(completion_smart_tab)
  imap <s-tab> <Plug>(completion_smart_s_tab)
endif
if nvim_native_lsp
  nnoremap gH <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
  nnoremap gS <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap gs <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
  vnoremap <leader>a <cmd>lua vim.lsp.buf.range_code_action()<CR>
  nnoremap <leader>f <cmd>lua vim.lsp.buf.code_action({only={'quickfix'}})<CR>
endif
if nvim_coc
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
  nnoremap <silent><nowait> gl  :<C-u>CocListResume<CR>
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

command! FF Neoformat prettier " Format file

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction

command What :exec "call SynStack() \n TSHighlightCapturesUnderCursor"

function! GotoWindow(id)
    call win_gotoid(a:id)
    " MaximizerToggle
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

set rtp+=~/.config/nvim/lush-template " Local colour scheme
colorscheme lush_template " Set theme

augroup Jumbub
  " Reset auto-commands when re-sourcing the rc
  au!
  " Prettier auto formatting
  au BufWritePre *.tsx,*.ts,*.js :Neoformat prettier
  " Picom autoreload config changes
  au BufWritePost picom.conf !pkill -USR1 picom || (picom &)
  " Automatically assign some arbitrary file types
  au BufEnter .babelrc :setlocal filetype=json
  " Setup vim inspector plugin
  au VimEnter * :packadd! vimspector
  " Test awesome window manager
  au BufWritePost /home/jamie/.config/awesome/* !/home/jamie/scripts/testWindowManager.sh
  " Show errors after x amount of time
  " au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
augroup END

if nvim
  " The color scheme is calculated at runtime
  lua require'colorizer'.setup()
endif

if nvim_native_ts
  " Native NVIM Tree sitter setup
  lua require'nvim-treesitter.configs'.setup { ensure_installed = 'maintained', highlight = { enable = true } };
endif

if nvim_native_lsp
  " Typescript
  lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
  " PHP
  lua require'lspconfig'.intelephense.setup{ on_attach=require'completion'.on_attach }
  " C/C++
  lua require'lspconfig'.ccls.setup{ on_attach=require'completion'.on_attach };
  " C#
  lua local pid = vim.fn.getpid(); local omnisharpBin = "/home/jamie/asdf/omnisharp/OmniSharp.exe"; require'lspconfig'.omnisharp.setup{ cmd={ omnisharpBin, "--languageserver" , "--hostPID", tostring(pid) }, on_attach=require'completion'.on_attach }
  " Python
  lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach };

lua <<EOF
  -- Wrap lsp actions with easier to use utilities
  vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  -- vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  -- vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  -- vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  -- vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  -- vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  -- vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  -- vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

  -- Remove virtual error text
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false
      }
  )

  -- Remove gutter indicators
  vim.fn.sign_define("LspDiagnosticsSignError", {text = "!", numhl = "LspDiagnosticsDefaultError"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "!", numhl = "LspDiagnosticsDefaultWarning"})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "!", numhl = "LspDiagnosticsDefaultInformation"})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = "!", numhl = "LspDiagnosticsDefaultHint"})
EOF
endif
