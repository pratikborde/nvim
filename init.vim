" Syntax {{{
" Enabling filetype support provides filetype-specific indentinvim_lspng,
" syntax highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on
set omnifunc=v:lua.vim.lsp.omnifunc
" }}}

" Runtime {{{
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim
" }}}

" Basic settings {{{
set autoindent                                " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start                " Proper backspace behavior.
set hidden                                    " Possibility to have more than one unsaved buffers.
set incsearch                                 " Incremental search, hit `<CR>` to stop.
set ruler                                     " Shows the current line number at the bottom-right of the screen.
set wildmenu                                  " Great command-line completion, use `<Tab>` to move around and `<CR>` to validate.
set number                                    " Shows the number line
set signcolumn=auto:1                            " Shows the sign column
set splitbelow                                " In case of split, opens below
set splitright                                " In case of vsplit, opens to the right
set clipboard+=unnamed                        " Clipboard support
set showmatch                                 " Show matching bracket on cursor hold
set cursorline                                " Highlight cursor line
set wrap                                      " Wrap long statements
set completeopt=menu,menuone,preview,noinsert " Options for completion menu
set autoread                                  " Ready file if it has been changed
set ignorecase                                " Ignore's case
set smartcase                                 " To ignore ignorecase in some cases
" }}}

" Backup settings {{{
set sessionoptions-=options
set viewoptions-=options
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

" Grep {{{
if executable('rg') 
	set grepprg=rg\ --column\ --no-heading\ --smart-case\ --follow\ --vimgrep
	set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" Plugins {{{
if empty(glob(substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", "")))
	call system("git clone --depth=1 https://github.com/Jorengarenar/minPlug ".substitute(&packpath, ",.*", "/pack/plugins/opt/minPlug", ""))
	autocmd VimEnter * nested silent! MinPlugInstall | echo "minPlug: INSTALLED"
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

" Create a new dir if it doesnt exists
autocmd GeneralSettings BufWritePre *
			\ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
			\ call mkdir(expand('<afile>:h'), 'p') |
			\ endif

" Set cwd on bufenter
autocmd GeneralSettings BufEnter * silent! Glcd

" Save session on exit
autocmd GeneralSettings VimLeave * call functions#sessionSave()

" Auto-resize splits when Vim gets resized.
autocmd GeneralSettings VimResized * wincmd =

" Run prettier on save
autocmd GeneralSettings FileType javascript,typescript,less,css,html call functions#prettierFormat()
autocmd GeneralSettings BufWritePost *.js,*.ts,*.tsx,*.jsx,*.html,*.css,*.less execute 'Make! %'
" }}}

" Colorscheme {{{
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
colorscheme xcodedark
set background=dark
" }}}

" Visual settings {{{
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬
set fillchars+=vert:│
set list
set statusline=\ ❮\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P\ ❯\ 
" }}}

" Commands {{{
" Grep for quickfix list
command! -nargs=+ -complete=file -bar Grep  cgetexpr functions#grep(<q-args>)
" Grep for location list
command! -nargs=+ -complete=file -bar LGrep lgetexpr functions#grep(<q-args>)
" Find files using vim-find-files
command! -nargs=+ -complete=dir Files :call find_files#execute(<q-args>, 'qf', <bang>0)
" Run jest test watcher
command! -nargs=1 -complete=file JestSingleFile call functions#jestRunForSingleFile()
" Save sessions (force)
command! -nargs=0 SessionSave call functions#sessionSave()
" Load sessions
command! -nargs=1 -complete=customlist,functions#sessionCompletePath SessionLoad call functions#sessionLoad(<q-args>)
" Git stash list
command! -nargs=0 Gstash :call functions#getGitStash()
" }}}

" Abbr {{{
call functions#setupCommandAbbrs('w','update')
call functions#setupCommandAbbrs('sov','source $MYVIMRC')
call functions#setupCommandAbbrs('Mi','MinPlugInstall')
call functions#setupCommandAbbrs('sload','SessionLoad')
call functions#setupCommandAbbrs('ssave','SessionSave')
call functions#setupCommandAbbrs('fd','Files')
call functions#setupCommandAbbrs('gr','Grep')
call functions#setupCommandAbbrs('gp','Dispatch! git push')
call functions#setupCommandAbbrs('gs','Gstash')
" }}}

" Plugin settings {{{
" Disvirsh
let g:loaded_netrwPlugin = 1                     " disable netrw
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r' " Sort dir at the top

                                                 " Find-files
let g:find_files_findprg = 'fd $*'               " Base command for find_files
let g:find_files_command_name = ''               " Remove original mapping

                                                 " Vim-qf
let g:qf_mapping_ack_style = 1                   " Qf mappings

" Nvim-lsp
lua << EOF
if vim.lsp then
	-- In case reloading
	vim.lsp.stop_client(vim.lsp.get_active_clients())

	local nvim_lsp = require'nvim_lsp'
	local servers = {'tsserver', 'vimls', 'cssls', 'jsonls', 'yamlls'}
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup {}
	end

	do
	local method = 'textDocument/publishDiagnostics'
	local default_callback = vim.lsp.callbacks[method]
	vim.lsp.callbacks[method] = function(err, method, result, client_id)
	default_callback(err, method, result, client_id)
	if result and result.diagnostics then
		for _, v in ipairs(result.diagnostics) do
			v.uri = v.uri or result.uri
		end
		vim.lsp.util.set_loclist(result.diagnostics)
	end
	end
  end
end
EOF
" }}}

" Mappings {{{
" Commands
nnoremap ; :
nnoremap : ;

" Clear highlights
nnoremap <space>/ :nohlsearch<CR>

" LSP
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gf	<cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gs	<cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gT	<cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references({ includeDeclaration = true })<CR>

" Omnifunc
inoremap <C-space> <C-x><C-o>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" keyword completion
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
" File name completion
inoremap        ,;      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
" Whole line completion
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR><Paste>

" Terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <space>te :tabe <bar> terminal<CR>

" Vim-qf
nmap <UP> <Plug>(qf_qf_toggle)
nmap <DOWN> <Plug>(qf_loc_toggle)

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
nnoremap <backspace> <C-^>
nnoremap gb :ls<CR>:b<Space>

" Open last searched qf
nnoremap <silent> <space>gr :execute 'Grep '.@/.' %'<CR>

" Window
nnoremap <space>w <C-w>
" }}}
