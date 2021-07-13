" Mostrar as linhas de forma relativa e absoluta
set relativenumber
set number
set numberwidth=3
map gn :set relativenumber!<CR>

" Mostra o nome do arquivo no título
set title

" Habilita contraste de termos buscados
set hlsearch

" TAB traduzido em 4 espaços
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Map autocomplete (apenas palavras no arquivo atual)(:help ins-completion para mais informações)
imap <S-Tab> <C-N>

" Ativa omnicompletion (<C-X><C-O>)
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Sem compatibilidade com Vi antigo
set nocompatible

" Colorir sintaxe
syntax enable 

" Definir que os subdiretórios referente ao atual também serão usados ao usar :find
set path+=**

" Habilita um menu para autocomplete do find
set wildmenu

set t_Co=256
set t_ut=
colorscheme jellybeans 

" Plugin manager
call plug#begin('~/.vim/plugged')
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-surround'
call plug#end()
