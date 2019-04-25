let mapleader = "," " My preferred leader. Just type , before many commands

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'janko/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'SirVer/ultisnips' 

" JavaScript specific
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'isRuslan/vim-es6'
Plug 'bigfish/vim-js-context-coloring'

" {{{ FZF 
	" Plugin outside ~/.vim/plugged with post-update hook
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'

	let g:fzf_vim_statusline = 0 " disable statusline overwriting

	" Search git tracked files
	nmap <Leader>fg :GFiles<CR>

	" Search global files
	nnoremap <silent> <leader><space> :Files<CR>
	nnoremap <silent> <leader>fb :Buffers<CR>
	nnoremap <silent> <leader>A :Windows<CR>
	nnoremap <silent> <leader>; :BLines<CR>
	nnoremap <silent> <leader>o :BTags<CR>
	nnoremap <silent> <leader>O :Tags<CR>
	nnoremap <silent> <leader>fh :History<CR>
	nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
	nnoremap <silent> <leader>. :AgIn
	nnoremap <silent> <leader>gl :Commits<CR>
	nnoremap <silent> <leader>ga :BCommits<CR>
	nnoremap <silent> <leader>ft :Filetypes<CR>

	" Search with AG
	nnoremap <silent> <leader>f :Ag<Space>
	nnoremap <silent> K :call SearchWordWithAg()<CR>
	vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

	imap <C-x><C-f> <plug>(fzf-complete-file-ag)
	imap <C-x><C-l> <plug>(fzf-complete-line)

	function! SearchWordWithAg()
		execute 'Ag' expand('<cword>')
	endfunction

	function! SearchVisualSelectionWithAg() range
		let old_reg = getreg('"')
		let old_regtype = getregtype('"')
		let old_clipboard = &clipboard
		set clipboard&
		normal! ""gvy
		let selection = getreg('"')
		call setreg('"', old_reg, old_regtype)
		let &clipboard = old_clipboard
		execute 'Ag' selection
	endfunction

	function! SearchWithAgInDirectory(...)
		call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
	endfunction
	command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
" }}}

" TESTING PLUGINS {{{
	Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" }}}
call plug#end()

" Appearance
" ====================================================================
colorscheme monokai
set background=dark

" VIM SETTINGS
" ====================================================================
" Enable filetype plugins
syntax on " Sources $VIMRUNTIME/syntax/syntax.vim
filetype plugin on
filetype indent on

set nocompatible " Turn of vi stuff -- nvim does this automatically
set autoread " Read when a file is changed externally
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse

set tabstop=2
set softtabstop=2
set noexpandtab " Use real tabs, not spaces
set shiftwidth=2 " Number of spaces to use for each step of (auto)indent.

set number " See line numbers
set relativenumber " use relative lines numbering by default

set nofoldenable " Do not collapse folds by default
set foldlevelstart=10
set foldnestmax=10
set foldmethod=marker

set scrolloff=999       " always keep cursor at the middle of screen
set virtualedit=onemore " allow the cursor to move just past the end of the line

set ignorecase
set smartcase

" {{{ CONVENIENCE KEYBINDS
	nnoremap <Leader><C-r> :so ~/.vimrc<CR>
	nnoremap <CR> : 

	nnoremap <Leader><ESC> :noh<CR> " ESC Clears search highlight

	nnoremap <space> za " Easy tab folding

	" Disable arrow keys... keeps ya honest
	noremap <Left> <nop>
	noremap <Right> <nop>
	noremap <Up> <nop>
	noremap <Down> <nop>
" }}}

" {{{ MOVEMENT KEYBINDS
	" Move vertically by visual line (fix line wrapping)
	noremap <expr> j v:count ? 'j' : 'gj'
	noremap <expr> k v:count ? 'k' : 'gk'

	" Super-H and Super-L (beginning / end of line)
	noremap H ^
	noremap L $

	" Disable arrow keys
	noremap <Left> <nop>
	noremap <Right> <nop>
	noremap <Up> <nop>
	noremap <Down> <nop>

	" Move vertically by visual line (fix line wrapping)
	noremap <expr> j v:count ? 'j' : 'gj'
	noremap <expr> k v:count ? 'k' : 'gk'
" }}}

" {{{ WINDOW MOVEMENT
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

	" Creating splits with empty buffers in all directions
	nnoremap <Leader>hh :leftabove vnew<CR>
	nnoremap <Leader>ll :rightbelow vnew<CR>
	nnoremap <Leader>kk :leftabove new<CR>
	nnoremap <Leader>jj :rightbelow new<CR>
" }}}
 
" {{{ PROGRAMMING HELPERS
	" Allow showing whitespace
	set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:⎵
	nnoremap <Leader><C-w> :set list!<CR>
" }}}

" Does not auto-comment lines starting with " in vim-type files 
" (such as this one)
" And auto-closes folds
au FileType vim setlocal comments-=:/" comments+=f:/"
au FileType vim normal zM

" {{{ JAVSCRIPT SETTINGS
	augroup javascript
    au!
    au filetype javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		let g:javascript_plugin_jsdoc = 1

		" make Vim use ES6 export statements as define statements
		let &l:define = '\v(export\s+(default\s+)?)?(var|let|const|(async\s+)?function|class)|export\s+'
	augroup END

	augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
	augroup END
" }}}
