" Enabling filetype support provides filetype-specific indentinvim_lspng,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on
set omnifunc=v:lua.vim.lsp.omnifunc

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" Basic settings {{{
set autoindent                       " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start       " Proper backspace behavior.
set hidden                           " Possibility to have more than one unsaved buffers.
set incsearch                        " Incremental search, hit `<CR>` to stop.
set ruler                            " Shows the current line number at the bottom-right of the screen.
set wildmenu                         " Great command-line completion, use `<Tab>` to move around and `<CR>` to validate.
set number                           " Shows the number line
set signcolumn=yes                   " Shows the sign column
set splitbelow                       " In case of split, opens below
set splitright                       " In case of vsplit, opens to the right
set clipboard+=unnamed               " Clipboard support
set showmatch                        " Show matching bracket on cursor hold
set cursorline                       " Highlight cursor line
set wrap                             " Wrap long statements
set completeopt=menu,menuone,preview " Options for completion menu
set autoread                         " Ready file if it has been changed
" }}}

" Backup settings {{{
set undofile    " Set this option to have full undo power
set backup      " Set this option to enable backup
set writebackup " Set this option to write back up
if has('nvim')
    set undodir=$HOME/.config/nvim/tmp/dir_undo
    set backupdir=$HOME/.config/nvim/tmp/dir_backup//
    set directory^=$HOME/.config/nvim/tmp/dir_swap//
else
    set backupdir=$HOME/.vim/tmp/dir_backup//
    set directory^=$HOME/.vim/tmp/dir_swap//
    set undodir=$HOME/.vim/tmp/dir_undo
endif
" }}}

" Plugins {{{
if empty(glob(substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", "")))
    call system("git clone --depth=1 https://github.com/Jorengarenar/minPlug ".substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", ""))
    autocmd VimEnter * silent! MinPlugInstall | echo "minPlug: INSTALLED"
endif

packadd minPlug
MinPlug neovim/nvim-lsp
MinPlug sheerun/vim-polyglot           " A solid language pack for Vim
MinPlug justinmk/vim-dirvish           " Directory viewer for Vim ⚡️
MinPlug tpope/vim-fugitive             " 💀 A Git wrapper so awesome, it should be illegal
MinPlug tpope/vim-eunuch               " Helpers for UNIX
MinPlug tpope/vim-dispatch             " Asynchronous build and test dispatcher
MinPlug tpope/vim-repeat               " repeat any command
MinPlug tpope/vim-surround             " quoting/parenthesizing made simple
MinPlug tpope/vim-commentary           " comment stuff out
MinPlug samoshkin/vim-find-files       " 🔎 Search for files and show results in a quickfix list
MinPlug romainl/vim-qf                 " Tame the quickfix window
MinPlug romainl/vim-cool               " A very simple plugin that makes hlsearch more useful
MinPlug godlygeek/tabular              " 🌻 A Vim alignment plugin
MinPlug markonm/traces.vim             " Range, pattern and substitute preview for Vim
MinPlug ciaranm/detectindent           " Vim script for automatically detecting indent settings
MinPlug arzg/vim-colors-xcode          " Xcode 11’s dark and light colourschemes, now for Vim!
MinPlug christoomey/vim-tmux-navigator
" }}}

" Autocmd {{{
augroup GeneralSettings
	autocmd!
augroup END

autocmd GeneralSettings ColorScheme * call functions#modifyBufferColors()
autocmd GeneralSettings ColorScheme * call functions#modifyLspColors()

" CREATE A NEW DIR IF IT DOESNT EXISTS
autocmd GeneralSettings BufWritePre *
			\ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
			\ call mkdir(expand('<afile>:h'), 'p') |
			\ endif

" Set cwd on bufenter
autocmd GeneralSettings BufEnter * silent! Glcd

" Quickfix
autocmd GeneralSettings QuickFixCmdPost cgetexpr cwindow
" Locationlist
autocmd GeneralSettings QuickFixCmdPost lgetexpr lwindow

autocmd GeneralSettings FileType javascript setlocal makeprg=prettier\ --write\ compact
autocmd GeneralSettings BufWritePost *.js,*.ts,*.tsx,*.jsx silent make! <afile> | silent redraw!
autocmd GeneralSettings QuickFixCmdPost [^l]* cwindow
" }}}

" Colorscheme {{{
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
colorscheme xcodedark " Sets colorscheme for neovim
set background=dark
" }}}

" Visual settings {{{
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬
set fillchars+=vert:│
set list
set statusline=\ ❮\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P\ ❯\ 
" }}}

" Grep {{{
if executable('rg') 
	set grepprg=rg\ --column\ --no-heading\ --smart-case\ --follow\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" Commands {{{
" Grep for quickfix list
command! -nargs=+ -complete=file -bar Grep  cgetexpr functions#grep(<q-args>)
" Grep for location list
command! -nargs=+ -complete=file -bar LGrep lgetexpr functions#grep(<q-args>)
" Find files using vim-find-files
command! -nargs=+ -complete=dir Files :call find_files#execute(<q-args>, 'qf', <bang>0)
" Format buffer
command! -nargs=0 Fmt execute 'lua vim.lsp.buf.formatting()'
" }}}

" Plugin settings {{{
" Disvirsh
let g:loaded_netrwPlugin = 1                     " disable netrw
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r' " Sort dir at the top

" Find-files
let g:find_files_findprg = 'fd $*'
let g:find_files_command_name = ''

" Nvim-lsp
lua << EOF
local nvim_lsp = require'nvim_lsp'
nvim_lsp.tsserver.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.cssls.setup{}
EOF
" }}}

" mappings {{{
" Commands
nnoremap ; :	
nnoremap : ;

" Clear highlights
nnoremap <space>/ :nohlsearch<CR>

" LSP
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gt	<cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs	<cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gT	<cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references({ includeDeclaration = true })<CR>

" Omnifunc
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,;      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR><Paste>

" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <space>te :tabe <bar> terminal<CR>

" Quickfix
nnoremap <silent> <UP> :cope<CR>
nnoremap <silent> <DOWN> :cclose<CR>
nnoremap <silent> <RIGHT> :cnext<CR>
nnoremap <silent> <LEFT> :cprev<CR>
nnoremap <silent> <S-RIGHT> :cnewer<CR>
nnoremap <silent> <S-LEFT> :colder<CR>

" Center search result line in screen
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz

" Substitue
nnoremap <space>sr :%s/<C-r><C-w>//gc<Left><Left><Left>
xnoremap <space>sr <Esc>:%s/<C-R><C-R>=<SID>functions#getVisualSelection()<CR>//gc<Left><Left><Left>

" CFDO
nnoremap <space>sc :cfdo %s/<C-r><C-w>//g \| update<S-Left><Left><Left><Left><Left><Left>
xnoremap <space>sc :cfdo %s/<C-R><C-R>=<SID>functions#getVisualSelection()<CR>//gc \| update<S-Left><S-Left><Left><Left><Left><Left>

" Tabularize
xnoremap ga :Tabularize /
nnoremap ga :Tabularize /

" Previous buffer
noremap <backspace> <C-^>

" Open last searched qf
nnoremap <silent> <space>gr :execute 'vimgrep /'.@/.'/g %'<CR>
" }}}
