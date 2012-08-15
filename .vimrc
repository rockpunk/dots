" How to find addon names?
" - look up source from pool (~/vim/vim-addon-manager-known-)
" - (<c-x><c-p> complete plugin names):
" You can use name rewritings to point to sources:
"    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
"    ..ActivateAddons(["github:user/repo", .. => github://user/repo
" Also see section "2.2. names of addons and addon sources" in VAM's documentation

let s:plugins = [
    \'ack',
    \'gnupg%3645',
    \'NERD_tree_Project',
    \'vcscommand',
    \'git-vim',
    \'github:altercation/vim-colors-solarized',
    \'snipmate',
    \'snipmate-snippets',
    \'SuperTab%1643',
    \'The_NERD_tree',
    \'The_NERD_Commenter',
    \'Command-T',
    \'fugitive',
    \'github:kien/rainbow_parentheses.vim',
    \'Vim-R-plugin',
    \'Screen_vim__gnu_screentmux',
    \'repeat',
    \'surround',
    \'taglist-plus',
    \'Syntastic',
    \'rails',
    \'vim-ruby'
    \]
let s:plugin_autoinstall = 1

" load vam
" --------
fun! EnsureVamIsOnDisk(vam_install_path)
    " windows users may want to use http://mawercer.de/~marc/vam/index.php
    " to fetch VAM, VAM-known-repositories and the listed plugins
    " without having to install curl, 7-zip and git tools first
    " -> BUG [4] (git-less installation)
    let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
    if eval(is_installed_c)
        return 1
    else
        if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
            " I'm sorry having to add this reminder. Eventually it'll pay off.
            call confirm("Remind yourself that most plugins ship with ".
                        \"documentation (README*, doc/*.txt). It is your ".
                        \"first source of knowledge. If you can't find ".
                        \"the info you're looking for in reasonable ".
                        \"time ask maintainers to improve documentation")
            call mkdir(a:vam_install_path, 'p')
            execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
            " VAM runs helptags automatically when you install or update 
            " plugins
            exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
        endif
        return eval(is_installed_c)
    endif
endf

fun! SetupVAM()
    " Set advanced options like this:
    " let g:vim_addon_manager = {}
    " let g:vim_addon_manager['key'] = value

    " Example: drop git sources unless git is in PATH. Same plugins can
    " be installed from www.vim.org. Lookup MergeSources to get more control
    " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
    " let g:vim_addon_manager.debug_activation = 1

    " VAM install location:
    let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
    if !EnsureVamIsOnDisk(vam_install_path)
        echohl ErrorMsg
        echomsg "No VAM found!"
        echohl NONE
        return
    endif
    exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

    " Tell VAM which plugins to fetch & load:
    call vam#ActivateAddons(s:plugins, {'auto_install' : s:plugin_autoinstall})
    " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
endfun
call SetupVAM()


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
let g:solarized_hitrail=1

if $SOLARIZED == 'light' || $SOLARIZED == 'dark'
    colorscheme solarized
    let &background=$SOLARIZED
endif

let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1

" the syntax checker for java depends on classpath and was buggy
let g:syntastic_mode_map = { 'mode':"active",
    \'active_filetypes' : [],
    \'passive_filetypes' : ['java'] }


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

call togglebg#map('<F5>')

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

