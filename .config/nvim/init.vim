" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes
" Put Plug 'url' here

Plug 'tmhedberg/SimpylFold' " nice cold folding
Plug 'vim-scripts/indentpython.vim' " auto indents
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree' " file tree
"Plug 'jistr/vim-nerdtree-tabs' " file tree WITH TABS WOOO
Plug 'tpope/vim-surround' " surround stuff with (c)hange(s)urr(thing)(othertinhg) also works with ds add stuff with ysiw(thing)
Plug 'git://github.com/aperezdc/vim-template.git' " Templates for newfiles etc
Plug 'https://github.com/ap/vim-buftabline.git' " Show all buffers somewhere
"Plug 'hkupty/iron.nvim' " repls
"Plug 'https://github.com/epeli/slimux' " send lines to tmux panes. repl plx
Plug 'kassio/neoterm' " send lines and files to neovim terminals
Plug 'morhetz/gruvbox' " a nice colorscheme
Plug 'justinmk/vim-sneak' " 2char jumping around for easier navving
Plug 'mhinz/vim-startify' " a nice start-screen that shows files and sessions etc
Plug 'michaeljsmith/vim-indent-object' " useful for python, adds 'i' text object for indented blocks. Like 'dai' 'delete an indented'
Plug 'scrooloose/nerdcommenter' " mass commenting for the masses 
Plug 'yuttie/comfortable-motion.vim' " smooth scrolling
Plug 'qpkorr/vim-bufkill' " kill buffers w/o closing the splits :BW
Plug 'kshenoy/vim-signature' " show marks on the left
Plug 'vimwiki/vimwiki' " make wikis in im
Plug 'kien/rainbow_parentheses.vim' " duh

" Initialize plugin system
call plug#end()

filetype plugin on " needed for nerdcommenter

set shell=zsh

set background=dark    " Setting dark mode
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

highlight StatusLineNC cterm=bold ctermfg=green ctermbg=darkgray

au VimEnter,Syntax,BufNewFile,BufRead *:
   \ RainbowParenthesesActivate
   \ RainbowParenthesesToggle
   \ RainbowParenthesesLoadRound
   \ RainbowParenthesesLoadSquare
   \ RainbowParenthesesLoadBraces

" hate this
:command W w
:command Q q

" Enable code folding for python files by indents
set foldmethod=indent
set foldlevel=99
set tabstop=4
set softtabstop=4
set shiftwidth=4

" For python files, set these
au BufNewFile,BufRead *.py:
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" wrap lines please
set wrap

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred

" Color the bad whitespaces
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Ignore files for nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Close YouCompleteMe window after completion
let g:ycm_autoclose_preview_window_after_completion=1
" Use py3
let g:ycm_python_binary_path = 'python3'

" Leave my keys alone thank you
let g:comfortable_motion_no_default_key_mappings = 1
       
" Syntax highlighting please             
let python_highlight_all=1
syntax on~


" Tell neoterm to use ipy3 as its repl
let g:neoterm_repl_python= 'ipython3'
" Vertical terminal splits please
let g:neoterm_position='vertical'

" Use templates for different files.
" Template files look like ->   =template=.py
" let g:templates_directory='~/Dropbox/ivir/dotfiles/vim_templates/'
" let g:templates_no_builtin_templates=1


" Line numbers please
set nu

" hilight the current line
set cursorline

" visual tab-autocomplete
set wildmenu


" enable mouse too, useful for resizing panes etc
set mouse=n
set splitbelow
set splitright




let mapleader=','

" turn off search highlight
nnoremap <leader>/ :nohlsearch<CR>


" NEOVIM ONLY

" Map left side to right side
" These get rid of c-w requirement for moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize panes
nnoremap <A-h> :vertical resize -10<CR>
nnoremap <A-j> :resize -3<CR>
nnoremap <A-k> :resize +3<CR>
nnoremap <A-l> :vertical resize +10<CR>

" map F5 to remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" save buffer
nnoremap <C-s> :w<CR>
nnoremap <C-S> :wa<CR>

" Buffers = tabs in any other editor
" Beware of terminals tho
set hidden
nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprev<CR>
nnoremap <C-w> :BW<CR>

" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

" Make navigation into and out of Neovim terminal splits nicer.
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Familiar send-line button for sending lines to repls
nnoremap <leader>s :TREPLSendLine<CR>
vnoremap <leader>s :TREPLSendSelection<CR>

" sends %run filename.py to ipy
nnoremap <leader>S :w<CR>:call neoterm#exec("%run " . expand('%') . "\n")<CR>

" smooth scroll half a page ish
" and center cursor
nnoremap <silent> <C-d> :call comfortable_motion#flick(50)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-50)<CR>
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

