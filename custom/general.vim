" COLORS AND STYLING {{{
set t_Co=256
set t_ut=
colorscheme srcery-drk
syntax enable
set background=dark 
set termguicolors
" }}}

" UI Config {{{
set softtabstop=4   " number of spaces in tab when editing
set number          " show line numbers
set ruler
set conceallevel =2
set cursorline      " highlight current line
set smartindent
set autoindent
set wrap
set linebreak
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to.
set showmatch
set noshowmode      " lightline shows the status not vim
set showcmd         " show command in bottom bar
" }}}

" FONT {{{
highlight Comment cterm=italic
highlight link xmlEndTag xmlTag
highlight htmlArg gui=italic
highlight Comment gui=italic
highlight Type gui=italic
highlight htmlArg cterm=italic
highlight Comment cterm=italic
highlight Type cterm=italic
" Italic garbage
let &t_8f="\<Esc>[38;2%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" }}}

" SEARCHING {{{
set incsearch " search as characters are entered
set smartcase
set ignorecase
" }}}

" FOLDING {{{
set foldenable        " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
" }}}

" UTILITIES {{{
set shell=/usr/local/bin/zsh
set nobackup
set nowritebackup
set noswapfile
set hidden
set history=100
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬
set fillchars+=vert:│
set list
set splitbelow
set splitright
set clipboard+=unnamed
set diffopt=vertical " Show diffs in vertical splits
set inccommand=split " highlights as you substitute

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
" }}}

set completeopt=menu,menuone,preview,noselect,noinsert
if executable('rg') 
	" Note we extract the column as well as the file and line number
	set grepprg=rg\ --column\ --vimgrep
endif