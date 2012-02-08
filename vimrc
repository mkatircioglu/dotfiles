" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
set backspace=2
set autoindent
set ruler
set showmode

syntax enable
set shiftwidth=4
set wrap
set linebreak
set laststatus=2
set showcmd
set wildmenu

set hlsearch
set incsearch
set showmatch
set background=dark
set modelines=0

set ts=4
set sta
set sts=4
set expandtab

set noswapfile

set ttyfast

" utf-8 default encoding
set enc=utf-8

" Prefer unix over windows over os9 formats
set fileformats=unix,dos,mac

" Make mouse middle click paste without formatting it
map <MouseMiddle> <Esc>"*p

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

set background=dark
set t_Co=256
" colorscheme solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

set makeprg=make

set showfulltag

" we don't want to edit these kind of files >.<
set wildignore=*.o,*.obj,*.bak,*.exe,*.so,*.la,*.out,*.pyc,*.swp

" No toolbars, menu or scrollbars in the GUI
if has('gui')
    set guioptions-=m  "no menu
    set guioptions-=T  "no toolbar
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r  "no scrollbar
    set guioptions-=R
end

" change the default setting in gvim
if has('gui_running')
    set gfn=DejavuSansMono\ 8
    " colorscheme solarized
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  " and set syntax to txt
  autocmd BufRead *.txt set tw=78
  autocmd BufRead *.txt set syntax=notes
  " enable python omni completion, rocks babe
  autocmd FileType python set omnifunc=pythoncomplete#Complete

  " Set the cwindow (quickfix) to the bottom of all windows
  autocmd FileType qf wincmd J

  autocmd BufRead *.c set makeprg=make
  autocmd BufRead *.cpp set makeprg=make
  autocmd BufRead *.h set makeprg=make
  autocmd BufRead *.hpp set makeprg=make

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" Don't use Ex mode, use Q for formatting
map Q gq
nmap <C-N><C-N> :set invnumber <CR>
map <Up> gk
map <Down> gj
map k gk
map j gj

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" <space> toggles folds opened and closed
nnoremap <space> za

" Enable filetype stuff
filetype on
filetype plugin on
filetype plugin indent on

"""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""

" NERDTree
nmap ,nt :NERDTreeToggle <CR>
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

" Toggle NERDTree and Tagbar simultaneously
function! ToggleNERDTreeAndTagbar()
    let w:jumpbacktohere = 1

    " Detect which plugins are open
    if exists('t:NERDTreeBufName')
        let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
    else
        let nerdtree_open = 0
    endif
    let tagbar_open = bufwinnr('__Tagbar__') != -1

    " Perform the appropriate action
    if nerdtree_open && tagbar_open
        NERDTreeClose
        TagbarClose
    elseif nerdtree_open
        TagbarOpen
    elseif tagbar_open
        NERDTree
    else
        NERDTree
        TagbarOpen
    endif

    " Jump back to the original window
    for window in range(1, winnr('$'))
        execute window . 'wincmd w'
        if exists('w:jumpbacktohere')
            unlet w:jumpbacktohere
            break
        endif
    endfor
endfunction
nmap <leader>\ :call ToggleNERDTreeAndTagbar()<CR>

" Filetypes configuration
"
" rst
autocmd BufNewFile,BufRead *.rst setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4  colorcolumn=79
\ formatoptions+=nqt textwidth=74

