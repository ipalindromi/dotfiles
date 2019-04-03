let mapleader = ","

" set pyxversion=3

" {{{ PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'Xuyuanp/nerdtree-git-plugin'
map <Leader>t :NERDTreeToggle<CR>

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"Plug 'Valloric/YouCompleteMe', { 'do': './insall.py --tern-completer' }
"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

Plug 'scrooloose/nerdcommenter'

Plug 'https://github.com/pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

Plug 'mxw/vim-jsx'
"Plug 'w0rp/ale'

" Easily run async shell commands in background
"Plug 'skywind3000/asyncrun.vim'

Plug 'janko/vim-test'

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1

"Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-obsession'
nnoremap <leader>ws :Obsess! dev.vim<CR>

Plug 'machakann/vim-highlightedyank'
" }}}
" Initialize plugin system
call plug#end()

" Appearance
" ====================================================================
colorscheme monokai
set background=dark


" {{{ FZF SEARCHING
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

nmap <Leader>, <plug>(Prettier)
let g:prettier#config#use_tabs = 'true'


" {{{ SETTINGS
" ==========================================
set ruler
set number

set nowrap

set laststatus=2

" Turn off bell
set vb t_vb=

set tabstop=2
set softtabstop=2
set noexpandtab
set shiftwidth=2

set foldenable

set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

set modelines=1

set wrap
set linebreak
set nolist

set nobackup

" Make commands easer
"nnoremap ; :
nnoremap <space>; :

" Make mode switching easier
"inoremap kj <ESC>
inoremap kj <ESC>
 
nnoremap <leader>w :w<CR>
 
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
 
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAKEN IN PART FROM: 
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc

set number         " show line numbers
set relativenumber " use relative lines numbering by default
set noswapfile     " disable creating of *.swp files
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse

set scrolloff=999       " always keep cursor at the middle of screen
set virtualedit=onemore " allow the cursor to move just past the end of the line
set undolevels=5000     " set maximum undo levels

" Enable filetype plugins
filetype plugin on
filetype indent on
"
" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

"
" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undofile
catch
endtry

autocmd FileType vim let b:vcm_tab_complete = 'vim'

" Show hidden characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,nbsp:⎵

" Toggle viewing whitespace
nnoremap <Leader><C-w> :set list!<CR>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" SPLITS  {{{
" Remap window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 
" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}

nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Same as above, except it opens unite at the end
nnoremap <silent> <Leader>h<Space> :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 1)<CR>
nnoremap <silent> <Leader>l<Space> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 1)<CR>
nnoremap <silent> <Leader>k<Space> :call JumpOrOpenNewSplit('k', ':leftabove split', 1)<CR>
nnoremap <silent> <Leader>j<Space> :call JumpOrOpenNewSplit('j', ':rightbelow split', 1)<CR>
" }}}

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Turns off auto comments
set formatoptions-=cro


" Enter clears search
" nnoremap <CR> :noh<CR><CR>

" https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
" omnifuncs;;
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Use of tags
"set tags+=./tags;
