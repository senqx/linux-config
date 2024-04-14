set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'              " Required
Plugin 'tpope/vim-fugitive'                " Git wrapper
Plugin 'xavierd/clang_complete'            " C++ LSP
Plugin 'majutsushi/tagbar'                 " Hierarchy tree <F8>
Plugin 'ntpeters/vim-better-whitespace'    " Trailing whitespace highlight <F7>
Plugin 'scrooloose/nerdtree'               " Directory tree view <F6>
Plugin 'joshdick/onedark.vim'              " Nice dark theme

call vundle#end()
filetype plugin indent on

let g:cklang_library_path='Path/To/Clang/Lib'  " Path to lib
let g:clang_complete_open=1                    " Show errors onn bottom
let g:clang_periodic_quickfix                  " Auto highlight errors

nmap <F8> :TagbarToggle<CR>
nmap <F7> :ToggleWhitespace<CR>
nmap <F6> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeFocus<CR>

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

set number

set cursorline
set cc=81

colorscheme onedark
syntax enable

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
let &t_ut=''
