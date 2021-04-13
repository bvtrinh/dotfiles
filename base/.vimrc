" Start pathogen - currently only using for Solarized
execute pathogen#infect()

" Highlight syntax
" See fancy justification for the following here:
" https://stackoverflow.com/questions/33380451/is-there-a-difference-between-syntax-on-and-syntax-enable-in-vimscript
if !exists("g:syntax_on")
    syntax enable
endif

" Add syntax highlighting for arm assembly files (.s)
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

" Each (auto) indent step is 4 spaces
set shiftwidth=4

" Insert spaces instead of a tab
set expandtab
" But not for HTML!
autocmd FileType html set noexpandtab

" Tabs are 4 spaces
set tabstop=4

" Set tabs and shifts to 2 spaces for javascript files
autocmd FileType javascript set shiftwidth=2 tabstop=2
" Use same indentation as previous line
set autoindent

" smartindent can interfere with the filetype [] commands below
set nosmartindent

" Set line number
autocmd VimEnter *.md setl number
" Indicate the current line.
autocmd VimEnter *.md set cursorline
" Enable spell check
autocmd VimEnter *.md set spell!

" Show what command I'm typing
set showcmd

" Highlight search matches
set hlsearch

" Show 256 colours
"set t_Co=256

" Dark background defaults
set background=dark

" Mouse scrolling
set mouse=a

" Set colorscheme
colorscheme solarized

" Show trailing whitespace
set list
if &encoding =~ "utf-8"
 set listchars=tab:›\ ,trail:·,extends:…,precedes:…,nbsp:‸
else
 set listchars=tab:>\ ,trail:.,extends:>,precedes:<,nbsp:.
endif

" Highlight specific terms
highlight SeeMe ctermfg=White ctermbg=Red
match SeeMe /NOTE/

" Set wrap length
set textwidth=72

" Make comments auto wrap
" c = auto-wrap comments using textwidth.
" r = auto-insert the comment char(s) when you press enter after a comment.
" o (missing) = don't insert a comment with the insert line o or O.
" q = Allow formatting of comments with the gq" command
" n = recognise numbered lists and wrap.
" l = don't break lines which are already too long.
set formatoptions=crqnl

" Custom commands
let mapleader = "\<C-h>"
map <F9> :setlocal spell!<CR>
map <C-l> :nohl<CR>
map <F11> :ColorHighlight<CR>

" Remove all trailing whitespace
nnoremap <leader>p :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
