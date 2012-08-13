filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" basic options
" -------------

" ignore vi
set nocompatible

" text options
" ------------
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smarttab
set smartindent
set textwidth=88
set encoding=utf-8
set modelines=10

" comments
" --------
set comments+=",b:##"
set formatoptions="tcnqrlo"

" display options
" ---------------
syntax on
set wildmenu
set showmatch
set gdefault " s//g instead of s// by default
set hlsearch
set incsearch " show search matches realtime
set showcmd  " show # of items selected below status line
set wildmenu
set wildmode=list:full
set scrolloff=3
set visualbell
set cursorline " highlight the cursor line
set t_Co=256 " use 256 colors
colorscheme elflord " set this to your default non-solarized colorscheme
set background=dark " your default background

if $SOLARIZED == "light" || $SOLARIZED == "dark"
    colorscheme solarized
    let &background=$SOLARIZED
endif

" highlight SpellBad groups brightly
highlight SpellBad cterm=underline,bold ctermfg=black ctermbg=DarkRed

" status line 
"set statusline=

" key mappings
" ---------------

" these subtle changes are actually quite great

" make jj leave insert mode
inoremap jj <ESC>
" use ; instead : for vim commands
nnoremap ; :

" move windows without C-W
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" use visual lines, not real lines
nnoremap j gj
nnoremap k gk

" use full line visual select by default
nnoremap v V
nnoremap V v

" disable arrow keys
noremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" use commas for macros
let mapleader=','

" make Y like D
nnoremap Y y$

" use perlre regex instead of vim's
nnoremap / /\v
vnoremap / /\v

" don't know about these yet
"nnoremap <tab> %
"vnoremap <tab> %

"pasttoggle
set pastetoggle=<C-v>

" macros
" ------

" quit no save
nnoremap <leader>Q :q!<cr>
nnoremap <leader>qq :q!<cr>
nnoremap <leader>qa :qa!<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>w :w<cr>

" turn off search highlighting
nnoremap <leader><space> :nohlsearch<cr>

" toggle line numbers
nnoremap <leader>1 :set invnumber<cr>

" ack!
nnoremap <leader>a :Ack<space>

" gq a paragraph
nnoremap <leader>q gqip

" underline with -/=/~/_
nnoremap <leader>- yypVr-
nnoremap <leader>= yypVr=
nnoremap <leader>~ yypVr~
nnoremap <leader>_ yypVr_

" edit vimrc
nnoremap <leader>ev :tabe ~/.vimrc<cr>

" tasklist, makegreen and command-t all map <leader>t
nnoremap <leader>td <Plug>TaskList
nnoremap <leader>mg <Plug>MakeGreen

" move vcs macros to <leader>v instead of <leader>c
let g:VCSCommandMapPrefix = '<leader>v'

" snippets stuff
let g:snips_author = 'stephen layland <cru@lindenlab.com>'

" tab completion
au FileType python set omnifunc=pythoncomplete#Complete fo=tcrno

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"augroup filetype
au! BufRead,BufNewFile *.proto setfiletype proto
au! BufRead,BufNewFile *.pig setfiletype pig
au! BufRead,BufNewFile *.{x,ht}ml, set ts=2 sw=2
"augroup end

"gnupg stuff
let g:GPGDefaultRecipients="steve@68k.org"
let g:GPGUseAgent=1
let g:GPGPreferArmor=1

" toggle bg
fu! ToggleBg()
    if &background=="dark"
        set background=light
    else
        set background=dark
    endif
endf

nnoremap <leader>bg :call ToggleBg()<cr>

" toggle Solarized
fu! ToggleSolarized()
    if g:solarized == 1
        colorscheme elflord
        let g:solarized=0
    else
        colorscheme solarized
        let g:solarized=1
    endif
endf

nnoremap <leader>ss :call ToggleSolarized()<cr>
