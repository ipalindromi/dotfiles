" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Appearance
" ====================================================================
colorscheme seti
set background=dark

Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgray   ctermbg=233
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgray ctermbg=235
" }}}

" Sensible defaults
Plug 'https://github.com/tpope/vim-sensible'

" post install (yarn install | npm install)
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Code surround tooling
Plug 'https://github.com/tpope/vim-surround'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
" Initialize plugin system
call plug#end()

let mapleader = ","

" {{{
  let g:fzf_vim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <leader>. :AgIn

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

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

" {{{
nmap <Leader>, <plug>(Prettier)
" }}}

" SETTINGS
" ==========================================
" {{{
set ruler
set number

set nowrap

set laststatus=2

" Turn off bell
set vb t_vb=

set tabstop=2
set softtabstop=2
set noexpandtab
set smartindent
set shiftwidth=4

set foldenable

set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set modelines=1

set wrap
set linebreak
set nolist

set nobackup

" Make commands easer
nnoremap ; :

" Make mode switching easier
inoremap kk <ESC>

" Open a new horizontal or vertical split
 nnoremap <leader>- :sp<CR>
 nnoremap <leader>\ :vsp<CR>
 
 nnoremap <leader>w :w<CR>
 
 " Remap window movement
 nnoremap <C-h> <C-w>h
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-l> <C-w>l
 
 nnoremap <Leader><C-r> :so ~/.vimrc<CR>
 
 " Search sanity
 " nnoremap / /\v
 " vnoremap / /\v
 set ignorecase
 set smartcase
 set gdefault
 set incsearch
 set showmatch
 set hlsearch
 
 nnoremap <tab> %
 vnoremap <tab> %
 
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
 " }}}
