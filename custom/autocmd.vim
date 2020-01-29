augroup GeneralSettings
	autocmd!
augroup END

" \ | highlight cursorline guibg=#333333
au GeneralSettings ColorScheme * highlight SignifySignAdd guifg=yellow guibg=NONE
	\ | highlight SignifySignDelete guifg=red  guibg=NONE
	\ | highlight SignifySignChange guifg=green guibg=NONE
	\ | highlight CocErrorSign guibg=NONE guifg=#ff0000
	\ | highlight CocWarningSign guibg=NONE guifg=#ff922b
	\ | highlight CocInfoSign guibg=NONE guifg=#fab005
	\ | highlight CocHintSign guibg=NONE guifg=#15aabf
	\ | highlight SignColumn guibg=clear-background
	\ | highlight StatusLine guibg=NONE guifg=#6C6C6C
	\ | highlight StatusLineNc guibg=NONE guifg=#4C4C4C
	\ | highlight VertSplit guibg=NONE
	\ | highlight TabLineFill guibg=NONE gui=NONE
	\ | highlight TabLineSel guibg=NONE guifg=#fcedda
	\ | highlight TabLine guibg=NONE
	\ | highlight LineNr guibg=NONE

" Update a buffer's contents on focus if it changed outside of Vim. {{{
au GeneralSettings FocusGained,BufEnter * :checktime
" }}}

" TERMINAL {{{
au GeneralSettings TermOpen * startinsert
au GeneralSettings BufEnter term://* startinsert
au GeneralSettings BufLeave term://* stopinsert
" }}}

" RESIZE {{{
" Auto-resize splits when Vim gets resized.
au GeneralSettings VimResized * wincmd =
" }}}

" Reduce delay when switching between modes. {{{
au GeneralSettings InsertEnter * set ttimeoutlen=0
au GeneralSettings InsertLeave * set ttimeoutlen=50
" }}}

" CREATE A NEW DIR IF IT DOESNT EXISTS {{{
au GeneralSettings BufWritePre *
	\ if '<afile>' !~ '^scp:' && !isdirectory(expand('<afile>:h')) |
		\ call mkdir(expand('<afile>:h'), 'p') |
	\ endif
" }}}
