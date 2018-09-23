"~/.config/nvim/init.vim

" Arrow keys disabled
    nmap <Up> <NOP>
    nmap <Down> <NOP>
    nmap <Left> <NOP>
    nmap <Right> <NOP>
    imap <Up> <NOP>
    imap <Down> <NOP>
    imap <Left> <NOP>
    imap <Right> <NOP>
    vmap <Up> <NOP>
    vmap <Down> <NOP>
    vmap <Left> <NOP>
    vmap <Right> <NOP>

" Config

    " Status bar
        set showcmd
        set laststatus=2

    " Indent
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        set autoindent
        set smartindent

    " Search
        set nohlsearch

    " Line number
        set nu
        set relativenumber

    " Max chars per line
        set colorcolumn=80
        set textwidth=80
        highlight ColorColumn ctermbg=darkgray

    " Specific language config
        filetype on
        autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

    " Misc
        set ttimeoutlen=100

" Normal Mapping (:help map-which-keys)

    " Go to previous tab
        nmap , gT

    " Throws the content after the cursor to the line below
        nmap <C-j> i<Enter><esc>k$

    " Enter (aka return) inserts new line below cursor (normal mode)
        nmap <CR> o<esc>

    " <F9>: Execute current Script
        nmap <F9> :w<Enter>:!clear<Enter>:!%:p<Enter>

" Insert Mapping

    " Change word case
        imap <C-u> <esc>gUiwea

" Commands

    command Vimrc tabe ~/.config/nvim/init.vim
    command MainSplit vertical resize 84 

" Plugins (requires: https://github.com/junegunn/vim-plug)

    call plug#begin('~/.config/nvim/bundle')
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'scrooloose/nerdcommenter'
        Plug 'tpope/vim-surround'
        Plug 'francoiscabrol/ranger.vim'
        Plug 'wellle/targets.vim'
        Plug 'andbar-ru/vim-unicon'
    call plug#end()

" Color

    colorscheme unicon
    set background=dark
    set cursorline

" Ranger Plugin

    let g:ranger_map_keys = 0
    map <leader>r :Ranger<Enter>
