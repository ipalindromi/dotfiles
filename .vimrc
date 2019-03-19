" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Appearance
" ====================================================================
Plug 'nanotech/jellybeans.vim'
" {{{
  let g:jellybeans_use_term_background_color = 0

   " {{{ Modified jellybeans theme
  let s:base03    = [ '#151513', 233 ]
  let s:base02    = [ '#30302c', 236 ]
  let s:base01    = [ '#4e4e43', 237 ]
  let s:base00    = [ '#666656', 242 ]
  let s:base0     = [ '#808070', 244 ]
  let s:base1     = [ '#949484', 246 ]
  let s:base2     = [ '#a8a897', 248 ]
  let s:base3     = [ '#e8e8d3', 253 ]
  let s:yellow    = [ '#ffb964', 215 ]
  let s:red       = [ '#cf6a4c', 167 ]
  let s:magenta   = [ '#f0a0c0', 217 ]
  let s:blue      = [ '#7697D6', 4   ]
  let s:orange    = [ '#ffb964', 215 ]
  let s:green     = [ '#99ad6a', 107 ]
  let s:white     = [ '#FCFCFC', 15  ]
" }}}

Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue']
" }}}

" Sensible defaults
Plug 'https://github.com/tpope/vim-sensible'

" Preferred theme
" Plug 'reewr/vim-monokai-phoenix'

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
