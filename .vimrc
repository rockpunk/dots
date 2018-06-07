set nocompatible | filetype indent plugin on | syn on

if has('nvim')
    let g:plug_vim_path = '~/.local/share/nvim/site/autoload/plug.vim'
else
    let g:plug_vim_path = '~/.vim/autoload/plug.vim'
endif

if empty(glob(g:plug_vim_path))
  silent exe '!curl -fLo ' . g:plug_vim_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

let g:python_host_prog=expand("~/.pyenv/versions/3.5.0/bin/python")
let g:python3_host_prog="/usr/bin/python3"
call plug#begin('~/.vim/plugs')

Plug 'inkarkat/vcscommand.vim'
Plug 'tpope/vim-fugitive'
Plug 'kien/rainbow_parentheses.vim'
Plug 'godlygeek/tabular'
Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mileszs/ack.vim'
if executable('ag')
    let g:ackprg = 'ag'
endif

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'hashivim/vim-terraform'

Plug 'jamessan/vim-gnupg'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.go = 'go#complete#Complete'
if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

"Plug 'jalvesaq/nvim-r', {'for':'r'}
Plug 'derekwyatt/vim-scala', {'for':'scala'}

if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf'
else
    Plug 'junegunn/fzf', {'dir':'~/.fzf', 'do':'./install --all'}
endif
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', {'for':'go'}

Plug 'w0rp/ale'
call plug#end()

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
colorscheme solarized " set this to your default non-solarized colorscheme
set background=dark " your default background
let g:solarized_hitrail=1
if $SOLARIZED == 'light' || $SOLARIZED == 'dark'
    colorscheme solarized
    let &background=$SOLARIZED
endif

let g:ale_fixers = {
\   'python':['yapf'],
\   'javascript': ['eslint'],
\   'java':['google-java-format'],
\}
"
"let g:ale_lint_on_text_changed=0
"let g:ale_lint_on_enter=1
"let g:ale_lint_on_save=1
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" syntastic stuff... deprecated for ALE
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:go_list_type = 'quickfix'

" the syntax checker for java depends on classpath and was buggy
let g:syntastic_mode_map = { 'mode':"active",
    \'active_filetypes' : [],
    \'passive_filetypes' : ["java","ruby","erb","go"] }

let g:go_fmt_fail_silently = 0

" highlight SpellBad groups brightly
highlight SpellBad cterm=underline,bold ctermfg=black ctermbg=DarkRed

" airline status bar
let g:airline_powerline_fonts = 1
let g:airline_detect_crypt = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
"let g:airline#extensions#tabline#alt_sep = 1
let g:airline#extensions#tabline#show_tabs=1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'



" crazy statusline from scrooloose
"""statusline setup
"""set statusline =%#identifier#
""set statusline+=[%f]    "tail of the filename
""set statusline+=%*
""
""set statusline+=%h      "help file flag
"""set statusline+=%y      "filetype
""
"""read only flag
""set statusline+=%#identifier#
""set statusline+=%r
""set statusline+=%*
""
"""modified flag
""set statusline+=%#identifier#
""set statusline+=%m
""set statusline+=%*
""
"""set statusline+=%{fugitive#statusline()}
""set statusline+=%#constant#
""set statusline+=%{VCSCommandGetStatusLine()}
""set statusline+=%*
""
"""set statusline+=%#warningmsg#
"""set statusline+=%{SyntasticStatuslineFlag()}
"""set statusline+=%*
""
"""display a warning if &paste is set
""set statusline+=%#error#
""set statusline+=%{&paste?'[paste]':''}
""set statusline+=%*
""
""set statusline+=%=      "left/right separator
"""set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
""set statusline+=%c,     "cursor column
""set statusline+=%l/%L   "cursor line/total lines
""set statusline+=\ %P    "percent through file
""
""set laststatus=2

let R_path="/usr/local/bin"

" key mappings
" ---------------

let maplocalleader='\'
" use commas for macros
let mapleader=','

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

"these don't currently work
"nnoremap <D-j> <C-F>
"nnoremap <D-k> <C-B>
"nnoremap <D-h> B
"nnoremap <D-l> E

nnoremap H :tabprevious<CR>
nnoremap L :tabnext<CR>
nnoremap <leader>bt :tab ball<CR>

" use visual lines, not real lines
nnoremap j gj
nnoremap k gk

" use full line visual select by default
nnoremap v V
nnoremap V v

" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>


" make Y like D
nnoremap Y y$

" use perlre regex instead of vim's
nnoremap / /\v
vnoremap / /\v

" don't know about these yet
nnoremap <tab> %
vnoremap <tab> %

"pastetoggle
set pastetoggle=<C-v>

nnoremap <leader>f :Files ~/src/analytics<cr>
nmap <leader>cl :Commits<cr>
nmap <leader>cs :GFiles?<cr>
nmap <leader>cd :NERDTreeToggle<cr>
"nnoremap <leader>u :FzfTags<cr>
"nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
" macros
" ------

" quit no save
nnoremap <leader>qq :qa!<cr>
nnoremap <leader>wq :waq<cr>

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

" go-git
nnoremap <leader>gb :GoBuild<cr>
nnoremap <leader>gr :GoRun<cr>
nnoremap <leader>gt :GoTest<cr>

" tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" snippets stuff
let g:snips_author = 'stephen layland <steve@68k.org>'

" tab completion
"au FileType python set omnifunc=pythoncomplete#Complete fo=tcrno
au FileType help nnoremap <buffer> <enter> :exec("tag ".expand("<cword>"))<cr>
au FileType help nnoremap <buffer> q :q<cr>
au FileType *.{x,ht}ml,ruby,eruby,yaml set ts=2 sw=2

let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"augroup filetype
filetype plugin indent on

au! BufRead,BufNewFile *.proto setfiletype proto
au! BufRead,BufNewFile *.pig setfiletype pig
au! BufRead,BufNewFile *.*{x,ht}ml set ts=2 sw=2

"au! BufRead,BufNewFile *.{x,ht}ml,ruby,eruby,yaml set ts=2 sw=2
autocmd BufRead *.java set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%# makeprg=ant\ -find\ build.xml

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"augroup end

"gnupg stuff
let g:GPGDefaultRecipients="steve@68k.org"
let g:GPGUseAgent=1
let g:GPGPreferArmor=1

"call togglebg#map('<F5>')

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

if !empty(glob("~/.config/nvim/nvim-init.vim") && has('nvim') )
    source ~/.config/nvim/nvim-init.vim
endif
call remote#host#RegisterPlugin('python3', '/Users/shougo/.vim/bundle/deoplete.nvim/rplugin/python3/deoplete.py', [
      \ {'sync': 1, 'name': 'DeopleteInitializePython', 'type': 'command', 'opts': {}},
\ ])
