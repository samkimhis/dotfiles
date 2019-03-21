" General {{{

" auto reload vimrc upon saving
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" CursorLine
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
"autocmd ColorScheme * hi CursorLine cterm=NONE ctermbg=darkred ctermfg=black guibg=darkred guifg=white
set cursorline
autocmd ColorScheme * hi CursorLine cterm=NONE ctermbg=237 guibg=#282a2e

" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

augroup vimrcFold
  " fold vimrc itself by categories
  autocmd!
  autocmd FileType vim set foldmethod=marker
  autocmd FileType vim set foldlevel=0
augroup END

" Set how many lines of history VIM should remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif
" Use space as leader key by mapping it to backslash
" map <Space> <Bslash>
" Allow the normal use of "," by pressing it twice
noremap ,, ,

" Leader key timeout
set tm=2000

" Use par for prettier line formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (this is a problem with libterm)
if has('nvim')
  nnoremap <BS> <C-w>h
endif

" }}}

" vim-plug {{{

set nocompatible

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

" Buffer bye: delete buffers without closing windows
Plug 'moll/vim-bbye'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Text manipulation
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'ConradIrwin/vim-bracketed-paste'

" Colorscheme
"Plug 'w0ng/vim-hybrid'
Plug 'samkimhis/vim-hybrid'
Plug 'chriskempson/base16-vim'

" Coding
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'lilydjwg/colorizer'
"Plug 'roxma/nvim-completion-manager'
"if !has('nvim')
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Writer's Toolbox
Plug 'lyokha/vim-xkbswitch'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'reedes/vim-wordy'
Plug 'dbmrq/vim-ditto'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'shime/vim-livedown'
Plug 'beloglazov/vim-online-thesaurus'
" :Thesaurus word
Plug 'Ron89/thesaurus_query.vim'
" <Leader>cs = Replace with synonym
Plug 'chrisbra/unicode.vim'
" :Digraphs! plus
" <C-x><C-z> = Complete unicode char

call plug#end()

" }}}

" VIM user interface {{{

" Set scroll offset (so) for cursor when moving vertically using j/k
set so=3
" Switch between centered scroll and default behavior
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
autocmd FileType pandoc setlocal so=999
"autocmd FileType pandoc setlocal so=30
" Smooth scroll
" https://stackoverflow.com/questions/4064651/what-is-the-best-way-to-do-smooth-scrolling-in-vim
function SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-U> :call SmoothScroll(1)<Enter>
nnoremap <C-D> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i

map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D>

" Turn on wildmenu
set wildmenu
set wildmode=list:longest,full

" Always show current position
set ruler
set number

" Show trailing whitespace
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Configure backspace as it should be
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Search options
set ignorecase
set smartcase
set hlsearch   " highlight
set incsearch  " incremental

" Don't redraw while executing macros (performance config)
set lazyredraw

" For regex turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
set mat=2  " how many tenths of a second to blink

" No annoying sound on errors
set noerrorbells
set vb t_vb=

" Turn mouse mode on
set mouse=a

" }}}

" Colors and Fonts {{{
set termguicolors

set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" Italicize comments (after colorscheme)
hi Comment cterm=italic gui=italic

" Set utf8 as standard encoding for VIM
if !has('nvim')
  set encoding=utf8
endif

" Use UNIX as the standard file type
set ffs=unix,dos,mac

" }}}

" Files, backups and undo {{{

" Turn off backup
set nobackup
set nowb
set noswapfile

" Source the vimrc file after saving it
augroup sourcing
  autocmd!
  if has('nvim')
    autocmd bufwritepost init.vim source $MYVIMRC
  else
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif
augroup END

" Fuzzy find files

" }}}

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces, unless the file is already using tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Linebreak on 500 characters
set lbr
"set tw=500

" Indentation
set ai   "auto indent
set si   "smart indent
set wrap "wrap lines

" Copy n paste to OS clipboard
nmap <leader>y "*y
vmap <leader>y "*y
nmap <leader>d "*d
vmap <leader>d "*d
nmap <leader>p "*p
vmap <leader>p "*p

set clipboard=unnamed " necessary for MacOS

" }}}

" Visual mode related {{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction


" }}}

" Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

noremap <c-h> <c-w>h
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-l> <c-w>l

" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

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

" don't close buffers when you aren't displaying them
set hidden

" previous buffer, next buffer
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

" close every window in current tabview but the current
nnoremap <leader>bo <c-w>o

" delete buffer without closing pane
"noremap <leader>bd :bd<cr>
noremap <leader>bd :Bdelete<cr>

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

" Easy expansion of active file directory
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Close help windows with just q
autocmd FileType help noremap <buffer> q :q<cr>

" }}}

" Status line {{{

" Always show the status line
set laststatus=2

" }}}

" Editing mappings {{{

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Spell checking {{{

set spell spelllang=en_us,cjk
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

" Use space bar to enter directory
let NERDTreeMapActivateNode='\<space>'

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
nmap <silent> <leader>f <ESC>:call ToggleFindNerd()<CR>
nmap <silent> <leader>F <ESC>:NERDTreeToggle<CR>

" }}}

" Alignment with Tabular {{{

" Align on equal signs
map <Leader>a= :Tab /=<CR>
" Align on commas
map <Leader>a, :Tab /,<CR>
" Align on pipes
map <Leader>a<bar> :Tab /<bar><CR>
" Prompt for align character
map <leader>ap :Tab /
" }}}

" Completion {{{

set completeopt+=longest

let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" }}}

" Plugin Settings {{{

" Vim_xkbswitch: keyboard switching
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'

" Colorizer:
let g:colorizer_maxlines = 1000

" Fugitive/Git-Gutter:
set diffopt+=vertical
set updatetime=100

" Fzf_vim:
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Goyo:
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_guifg = '#373b41'
let g:limelight_conceal_ctermfg = 238

" automatically enter Goyo mode for markdown
"au FileType pandoc Goyo 80
"
"function! s:auto_goyo()
"  if &ft == 'pandoc'
"    Goyo 80
"  elseif exists('#goyo')
"    let bufnr = bufnr('%')
"    Goyo!
"    execute 'b '.bufnr
"  endif
"endfunction
"
"augroup goyo_markdown
"  autocmd!
"  autocmd BufNewFile,BufRead * call s:auto_goyo()
""  autocmd BufEnter * call s:auto_goyo()
"augroup END

" Thesaurus_vim:
let g:tq_openoffice_en_file="~/.config/nvim/spell/th_en_US_new"
let g:tq_enabled_backends=["openoffice_en","mthesaur_txt"]

" Vim_airline:
let g:airline_theme='base16color'
let g:airline#extensions#tabline#enabled = 1
" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"

" Vim_pandoc:
let g:pandoc#syntax#codeblocks#embeds#langs = ["r", "haskell", "zsh", "sh"]
let g:pandoc#folding#fdc = 0 "Turn off folding gutter
let g:pandoc#biblio#sources = "clg"
"let g:pandoc#completion#bib#mode = 'citeproc'  "citeproc is too slow
"let g:pandoc#biblio#bibs = ["/Users/$USER/.pandoc/zotero-bibtex/default.bib"]
let g:pandoc#command#latex_engine = 'lualatex'

" Rainbow_paren:
" https://github.com/kien/rainbow_parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Vim_livedown:
nmap <leader>l :LivedownToggle<CR>
let g:livedown_browser = "safari"

" }}}
