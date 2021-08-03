" Mostrar as linhas de forma relativa e absoluta
set relativenumber
set number
set numberwidth=3
map gn :set relativenumber!<CR>

" Comando de subtituição passa por um preview
" set inccommand=nosplit

" buscas em caixa baixa são insensitive case
set smartcase

" Mostra o nome do arquivo no título
set title

" Habilita contraste de termos buscados
set hlsearch

" TAB traduzido em 4 espaços
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Map autocomplete (apenas palavras no arquivo atual)(:help ins-completion para mais informações)
imap <S-Tab> <C-N>

" Atalhos para gerenciamento de registradores
" clipboard vai para o registrador + (padrão utilizado pelo vim)
set clipboard=unnamedplus 
map <F5> "a
map <F6> "b
map <F7> "c
map <F8> "d
map <F9> "e

" plugin
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Sem compatibilidade com Vi antigo
set nocompatible

" Colorir sintaxe
syntax enable 

" Inicia busca por arquivos
map ge :Explore <CR>

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
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'machakann/vim-highlightedyank'
call plug#end()

" Atalho para o Fuzzy Finder
map <C-P> :FZF <CR>

" Duração do highlightedyank
let g:highlightedyank_highlight_duration = 200
