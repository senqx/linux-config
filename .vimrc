" Initial setup
set nocompatible
filetype off

" Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'             " Required
Plugin 'tpope/vim-fugitive'               " Git wrapper
Plugin 'ycm-core/YouCompleteMe'           " C++ autocomplete
Plugin 'majutsushi/tagbar'                " Hierarchy tree <F8>
Plugin 'ntpeters/vim-better-whitespace'   " Trailing whitespace <F7>
Plugin 'scrooloose/nerdtree'              " TreeView <F6>
Plugin 'joshdick/onedark.vim'             " Nice dark theme
Plugin 'itchyny/lightline.vim'            " Status bar
Plugin 'octol/vim-cpp-enhanced-highlight' " Enhanced C++ syntax
Plugin 'tpope/vim-commentary'             " Easy commenting

call vundle#end()
filetype plugin indent on

" Key mappings
nmap <F8> :TagbarToggle<CR>
nmap <F7> :ToggleWhitespace<CR>
nmap <F6> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFocus<CR>

" YouCompleteMe settings
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

" Status bar settings
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

" General settings
syntax on                   " Enable syntax highlighting
set number                  " Show line numbers
set cursorline              " Highlight current line
set tabstop=2               " Tab width
set shiftwidth=2            " Indentation width for auto-indents
set softtabstop=2           " Make backspace more natural
set expandtab               " Use spaces instead of tabs
set autoindent              " Maintain indentation of previous line
set smartindent             " Auto-indent in a smarter way
set showmatch               " Highlight matching brackets
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive search
set smartcase               " Case-sensitive if uppercase letter is used
set clipboard=unnamedplus   " Use system clipboard
set nowrap                  " Don't wrap lines
set cc=81                   " Highlight 81th column (Keep the code concise)
set encoding=utf-8          " Ensure compatibility
set backspace=2             " Fix backspace

colorscheme onedark
