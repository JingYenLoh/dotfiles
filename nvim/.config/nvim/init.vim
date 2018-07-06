""" PLUGINS_BEGIN
call plug#begin('~/.local/share/nvim/plugged')

" NERDTree, because why not?
Plug 'scrooloose/nerdtree'

" Goyo. Turns out writing drafts in Vim is actually pretty good
Plug 'junegunn/goyo.vim'

" Auto-pairs
Plug 'jiangmiao/auto-pairs'

" Deoplete (autocomplete)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python autocompletion
Plug 'zchee/deoplete-jedi'
" Deoplete-ternjs plugin
Plug 'carlitux/deoplete-ternjs'

" Try out deol shell
Plug 'Shougo/deol.nvim'

" Javascript & jsx syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" ALE linting
Plug 'w0rp/ale'

" EasyAlign
Plug 'junegunn/vim-easy-align'

" Vim colorscheme
Plug 'crusoexia/vim-monokai'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
Plug 'dracula/vim', { 'as': 'dracula' }

" Better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Denite vim
Plug 'Shougo/denite.nvim'

" Comment stuff out
Plug 'tpope/vim-commentary'
" Repeat plugin commands!
Plug 'tpope/vim-repeat'
" Vim surround
Plug 'tpope/vim-surround'
" Context aware substituition thing
Plug 'tpope/tpope-vim-abolish'
" Modify dates like a pro
Plug 'tpope/vim-speeddating'
" Vim wrapper for UNIX commands
Plug 'tpope/vim-fugitive'
" Readline bindings in INSERT mode
Plug 'tpope/vim-rsi'
" Smart indentation based on history
Plug 'tpope/vim-sleuth'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" f or F on steroids (Testing out vim-sneak atm)
Plug 'unblevable/quick-scope'

" Tmux and vim navigation
Plug 'christoomey/vim-tmux-navigator'

" Jump to any location specified by 2 chars
Plug 'justinmk/vim-sneak'

" Vim autoformat magics!
Plug 'Chiel92/vim-autoformat'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Easymotion (need to change my thinking too)
Plug 'easymotion/vim-easymotion'

" So apparently I'm using Vue now
Plug 'posva/vim-vue'

" .NET Core...
Plug 'OrangeT/vim-csharp'

call plug#end()
""" PLUGINS_END

" Use fd for escaping
imap fd <Esc>

" Set leader key to space
let g:mapleader = "\<Space>"
" Set local leader  key to ;
let g:maplocalleader = ";"

" Ctrl p settings
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

" Airline settings
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1

" Display relative line numbers
set number
set relativenumber

" Color settings
set termguicolors
colorscheme dracula
" set background=dark
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
let g:tern_show_signature_in_pum='0'

" Add extra filetypes
let g:tern#filetypes = ['jsx', 'javascript.jsx', 'vue']

" Keep sign gutter always open
let g:ale_sign_column_always=1

" Integrate ALE with airline
let g:airline#extensions#ale#enabled = 1

" Try to make fasd work
function! s:fasd_update() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction

augroup fasd
  autocmd!
  autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END

" Enable jsx syntax highlighting in .js files
let g:jsx_ext_required=0

" Mimic Doom Emacs toggle tree
nmap <leader>on :NERDTreeToggle<CR>

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
nmap <leader>b[ :bnext<CR>
nmap <leader>b] :bprevious<CR>
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
