" Tecla leader sendo Alt
let mapleader = "\\"

" plugin
filetype plugin on
" set omnifunc=syntaxcomplete#Complete

" Plugin manager
call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    " Plug 'tpope/vim-vinegar'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'machakann/vim-highlightedyank'
    Plug 'ap/vim-css-color'
    Plug 'ycm-core/YouCompleteMe'
    " Plug 'mattn/emmet-vim'"Deixa o Vim muito lento
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Ao usar o autocomplete não será aberta uma nova janela com a definição do termo
set completeopt-=preview

" Atalhos para YouCompleteMe
map gd :YcmCompleter GoTo <CR>

" Duração do highlightedyank
let g:highlightedyank_highlight_duration = 200

" Definindo tema para vim-airline
let g:airline_theme='luna'

" Definindo a leader key do Emmet
" let g:user_emmet_leader_key='<C-M>'

" Y copia até o fim da linha
nnoremap Y y$

" Atalhos para gerenciamento de registradores
" clipboard vai para o registrador + (padrão utilizado pelo vim)
set clipboard=unnamedplus

" Movimentos entre janelas com a tecla leader
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" Map autocomplete (apenas palavras no arquivo atual)(:help ins-completion para mais informações)
imap <S-Tab> <C-N>

" Inicia Netrw
" map ge :Vex <CR>
map ge :NERDTreeToggle<CR>

" Atalho para o Fuzzy Finder
map <C-P> :FZF <CR>

" Esquema de cores
set t_Co=256
set t_ut=
syntax enable
colorscheme jellybeans

" Mostrar as linhas de forma relativa e absoluta
set relativenumber
set number
set numberwidth=3
map gn :set relativenumber!<CR>

" Comando de subtituição passa por um preview (somente neovim)
" set inccommand=nosplit

" Faz com que a exibição de uma linha longa seja quebrada, porém o texto original contém a linha sem limite
set wrap

" Mostra os comandos digitados em normal mode
set showcmd

" buscas em caixa baixa são insensitive case
set smartcase

" Mostra o nome do arquivo no título
set title

" Habilita contraste de termos buscados
set hlsearch

" TAB traduzido em 4 espaços
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Sem compatibilidade com Vi antigo
set nocompatible

" Definir que os subdiretórios referente ao atual também serão usados ao usar :find
set path+=**

" Habilita um menu para autocomplete do find
set wildmenu

" Configuração do Netrw
" let g:netrw_liststyle = 3
" let g:netrw_banner = 0
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 20
" let g:netrw_sort_sequence = '[\/]$,*'
" let g:netrw_altv = 1

