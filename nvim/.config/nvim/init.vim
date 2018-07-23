""" PLUGINS_BEGIN
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/deol.nvim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'crusoexia/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'unblevable/quick-scope'
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-sneak'
Plug 'Chiel92/vim-autoformat'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'posva/vim-vue'
Plug 'OrangeT/vim-csharp'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()
""" PLUGINS_END

" Use fd for escaping
imap fd <Esc>

" Work with mouse
set mouse=a

" Set leader key to space
let g:mapleader="\<Space>"
" Set local leader  key to ,
let g:maplocalleader=","

" Airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled=1

" Display relative line numbers
set number
set relativenumber

" Color settings
set termguicolors
colorscheme one
set background=dark
let g:one_allow_italics=1
syntax enable

" Tab settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set copyindent

" UI settings
set hidden
set showcmd
set cursorline
set wildmenu
set showmatch
set nobackup
set noswapfile
" let &colorcolumn="80,".join(range(119, 999),",")

" Split settings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase

" Fold settings
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_smart_case=1
let g:tern_show_signature_in_pum='0'

" Add extra filetypes
let g:tern#filetypes=['jsx', 'javascript.jsx', 'vue']

" Keep sign gutter always open
let g:ale_sign_column_always=1
let g:ale_sign_error='⨉'
let g:ale_sign_warning='⚠'
let g:ale_statusline_format=['⨉ %d', '⚠ %d', '']
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_save=1
let g:ale_lint_on_enter=1

" Integrate ALE with airline
let g:airline#extensions#ale#enabled=1

" Enable jsx syntax highlighting in .js files
let g:jsx_ext_required=0

" Mimic Doom Emacs toggle tree
nmap <leader>op :NERDTreeToggle<CR>

" NERDTree ignore certain filetypes cos clutter
let NERDTreeIgnore = [ '\.class$', '\.pyc$' ]

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Trigger a highlight in the appropriate direction when pressing these keys:
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Map autoformat shortcut
noremap <leader>ed :Autoformat<CR>
noremap <localleader>g :Denite<CR>

" Mimic Doom Emacs buffers
nmap <leader>b] :bnext<CR>
nmap <leader>b[ :bprevious<CR>
nmap <leader>bk :bdelete<CR>

" Mimic Doom Emacs quit and save
nmap <leader>qq :q!<CR>
nmap <leader>bs :w<CR>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" LSP settings
let g:LanguageClient_serverCommands={
    \ 'docker': ['docker-langserver', '--stdio'],
    \ 'sh': ['bash-language-server', 'start']
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <leader>oT :Deol -split<CR>

" Denite
augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call denite#custom#option('default',
        \'winheight', winheight(0) / 2)
augroup end

call denite#custom#var('file_rec', 'command',
  \ ['rg', '--files', '--glob', '!.git', ''])
nnoremap <C-p> :<C-u>Denite file_rec<CR>

