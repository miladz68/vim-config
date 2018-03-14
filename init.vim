
syntax on
"set to auto read when a file is changed from the outside set autoread
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,



" allows easier tab naviagtion
" Control + l -> next tab
" Control + h -> prevoius tab
" Control + n -> new tab
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

set nocompatible
set number
set nowrap
set showmode
set tw=80
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set mouse=a
set history=1000
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
"set clipboard=unnamedplus,autoselect
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

" Ignore case when searching
set ignorecase


set t_Co=256

set cmdheight=1

" vim-plug {{{

call plug#begin('~/.config/nvim/bundle')


" Support bundles
Plug 'jgdavey/tslime.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'ervandew/supertab'
" Plug 'scrooloose/syntastic'
Plug 'w0rp/ale' "I think this and syntastic collide
Plug 'skywind3000/asyncrun.vim'
" Plug 'benekastah/neomake'
"Plug 'moll/vim-bbye'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
" Text manipulation
"Plug 'vim-scripts/Align'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
"Plug 'michaeljsmith/vim-indent-object'
"Plug 'easymotion/vim-easymotion'
"Plug 'ConradIrwin/vim-bracketed-paste'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'


" Allow pane movement to jump out of vim into tmux
Plug 'christoomey/vim-tmux-navigator'


" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'owickstrom/neovim-ghci', { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Golang
Plug 'fatih/vim-go', { 'for': 'go' }

" HTML CSS
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'ryym/vim-riot'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Color Scheme
Plug 'joshdick/onedark.vim'
Plug 'sickill/vim-monokai'
Plug 'vim-scripts/wombat256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jdkanani/vim-material-theme'
call plug#end()


"settings for Ale
"eslint 
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
" autocmd BufWritePost *.js AsyncRun -post=checktime $HOME/.yarn/bin/eslint --fix %
autocmd BufWritePost *.js ALEFix 
" autocmd BufWritePost *.go silent call <SID>build_go_files() 

"settings for emmet 
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" settigns for vim-go
set autowrite
" autocmd FileType go nmap <leader>gb  <Plug>(go-build)
" autocmd FileType go nmap <leader>gr  <Plug>(go-run)
" autocmd FileType go nmap <leader>gt  <Plug>(go-test)
autocmd FileType go nmap <leader>gi  :GoInfo<CR>
autocmd FileType go nmap <leader>gd  :GoDoc<CR>
autocmd FileType go nmap <leader>gn  :cnext<CR> 
autocmd FileType go nmap <leader>gp  :cprevious<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
autocmd BufWritePost *.go silent call <SID>build_go_files() 


augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H 
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>
  " au FileType haskell nnoremap <silent> <leader>ir :InteroReload<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>ht <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>hi <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>hT :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>hd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END



" == ghc-mod ==

" nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hs :GhcModSplitFunCase<CR>
" nmap <silent> <leader>ht :GhcModType<CR>
" nmap <silent> <leader>he :GhcModTypeClear<CR>
" nmap <silent> <leader>hi :GhcModInfo<CR>
" nmap <silent> <leader>hp :GhcModInfoPreview<CR>
nmap <silent> <leader>hc :GhcModCheck<CR>
nmap <silent> <leader>hl :GhcModLint<CR>


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"colorscheme onedark
"colorscheme wombat256mod
"colorscheme monokai
"set background=dark
colorscheme PaperColor
set background=dark
" colorscheme material-theme

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless the file is already
" using tabs, in which case tabs will be inserted.
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Copy and paste to os clipboard
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>d "+d
vmap <leader>d "+d
nmap <leader>p "+p
vmap <leader>p "+p

" }}}


" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%



" fuzzy find buffers
" == ctrl-p ==

map <silent> <Leader><space> :CtrlP()<CR>
noremap <leader>b<space> :CtrlPBuffer<cr>
map <silent> <Leader>t :tabnew <bar> :CtrlP()<CR>
let g:ctrlp_custom_ignore = '\v[\/]dist$'

map <silent> <Leader>qq :q<CR>
" Neovim terminal configurations
if has('nvim')
  " Use <Esc> to escape terminal insert mode
  tnoremap <Esc> <C-\><C-n>
  " Make terminal split moving behave like normal neovim
  tnoremap <c-h> <C-\><C-n><C-w>h
  tnoremap <c-j> <C-\><C-n><C-w>j
  tnoremap <c-k> <C-\><C-n><C-w>k
  tnoremap <c-l> <C-\><C-n><C-w>l
endif

" Spell checking {{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" }}}

"Slime {{{

vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

map <silent> <Leader>n :NERDTreeToggle<cr>

" }}}

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align
" }}}

" Tags {{{

map <leader>tt :TagbarToggle<CR>

set tags=tags;/
set cst
set csverb

" }}}

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" == neco-ghc ==

let g:haskellmode_completion_ghc = 0 
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
