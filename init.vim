set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plug 'VundleVim/Vundle.vim'

    " my plugins
    Plug 'vim-vdebug/vdebug'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug '~/.fzf'

    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'garbas/vim-snipmate'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdtree'
    Plug 'vim-scripts/BufOnly.vim'

    " All of your Plugins must be added before the following line
call plug#end()            " required

syntax enable
set background=dark
colorscheme solarized

set backspace=indent,eol,start             "Make backspace behave like other editors"
let mapleader = ','                        "Set comma as default Leader"
set number                                 "Let's activate line numbers"

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set mouse=a
set nowrap

inoremap {<CR>  {<CR>}<Esc>O

"-----------------Searching----------------"
set incsearch
set hlsearch
nmap <Leader><space> :nohlsearch<cr>

"-----------------Mappings----------------"
nmap vv V
nmap - :Explore<cr>

imap jj <esc>
nmap <Leader>ev :tabedit $MYVIMRC<cr>

nmap <Leader>- :Explore<cr>

nmap <C-h> :tabp<cr>
nmap <C-l> :tabn<cr>

inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
nmap <C-b> :NERDTreeToggle<cr>

"-----------------Buffers----------------"
map <F2> :ls<CR>:b<Space>
map <F4> :BufOnly<cr>
map <Leader>bl :ls<CR>:b<Space>
map <Leader>bo :BufOnly<cr>
nmap <Leader>bd :bd<cr>
nmap <Leader>bn :bn<cr>
nmap <Leader>bp :bp<cr>
"-----------------Split management----------------"
set splitbelow
set splitright
"-----------------Highlighting----------------"
:highlight LineNr ctermfg=white ctermbg=NONE

"-----------------Auto-Commands----------------"
"Automatically source .vimrc on save"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

autocmd BufWritePre * %s/\s\+$//e
"------------------Multi-Cursor-----------------"
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse

"------------------Allow external .vimrc/.nvimrc-----------------"
set exrc
set secure " external .nvimrc has to be owned by current user to use 'unsafe' commands in it
"-----------------Ctrl-P specific-----------------"
"let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
"if executable('ag')
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif
"
"if exists("g:ctrl_user_command")
"  unlet g:ctrlp_user_command
"endif
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

"-----------------Statusline-----------------"
set updatetime=100 " set gitgutter's update time to 100 ms

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

"-----------------Set undo and swap dirs-----------------"
function! SafeMkdir(path)
    if !isdirectory(a:path)
        call mkdir(a:path, "p", 0700)
    endif
endfunction

call SafeMkdir($HOME . "/.config/nvim/swap")
set swapfile
set directory=$HOME/.config/nvim/swap//

call SafeMkdir($HOME . "/.config/nvim/undo")
set undofile
set undodir=$HOME/.config/nvim/undo//

"-----------------coc config-----------------"
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
"nmap <silent> <leader>gr <Plug>(coc-references)

"----------------- Fuzzy File Search -----------------"
nmap <Leader>f :FZF<CR>
nmap <Leader>F :FZF ~<CR>
"--------------- Vdebug -------------------"
if !exists("g:vdebug_options")
    let g:vdebug_options = {}
endif
let g:vdebug_options.break_on_open = 1
