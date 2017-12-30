"set nocompatible | filetype indent plugin on | syn on

let s:plugins = []

call add(s:plugins, {'names':[
    \'vcscommand',
    \'Syntastic',
    \'fugitive',
    \'github:kien/rainbow_parentheses.vim',
    \'github:godlygeek/tabular',
    \'github:altercation/vim-colors-solarized',
    \], 'tag':'autoload'})

"call add(s:plugins, {'names':[
"    \], 'tag':'autoload'})

call add(s:plugins, {'names':[
    \'ack',
    \'NERD_tree_Project',
    \'The_NERD_tree',
    \'The_NERD_Commenter'
    \], 'tag':'shell'})

call add(s:plugins, {'names':[
    \'repeat',
    \'speeddating',
    \'surround'
    \], 'tag':'useful'})

call add(s:plugins, {'name':'github:jamessan/vim-gnupg'})
call add(s:plugins, {'name':'github:derekwyatt/vim-scala','filename_regex':'\.sc(ala)?$'})
call add(s:plugins, {'name':'github:platicboy/vim-markdown','filename_regex':'\.md$'})
call add(s:plugins, {'names':['github:guns/vim-clojure-static','github:guns/vim-clojure-highlight'],'filename_regex':'.clj$'})
call add(s:plugins, {'names':['rails','vim-ruby'],'filename_regex':'\.rb$'})
call add(s:plugins, {'name':'github:fatih/vim-go','filename_regex':'\.go$'})
call add(s:plugins, {'name':'Nvim-R','filename_regex':'\.R$'})
"call add(s:plugins, {'name':'github:vim-scripts/taglist.vim'})

"    \'github:Valloric/YouCompleteMe',
"    \'snipmate',
"    \'snipmate-snippets',
"    \'SuperTab%1643',
"    \'Command-T',
"    \'Vim-R-plugin',


fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  
  " auto-install if plugin doesn't exist without asking
  let c.auto_install = 1
  " don't show those hit Enter to continue dialogs
  let c.log_to_buf = 1

  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

call vam#Scripts(s:plugins, {'tag_regex':'autoload'})

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

" crazy statusline from scrooloose
"statusline setup
"set statusline =%#identifier#
set statusline+=[%f]    "tail of the filename
set statusline+=%*

set statusline+=%h      "help file flag
"set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

"set statusline+=%{fugitive#statusline()}
set statusline+=%#constant#
set statusline+=%{VCSCommandGetStatusLine()}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set laststatus=2

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

nnoremap <D-j> <C-F>
nnoremap <D-k> <C-B>
nnoremap <D-h> B
nnoremap <D-l> E


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


" make Y like D
nnoremap Y y$

" use perlre regex instead of vim's
nnoremap / /\v
vnoremap / /\v

" don't know about these yet
"nnoremap <tab> %
"vnoremap <tab> %

"pastetoggle
set pastetoggle=<C-v>

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
