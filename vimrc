" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" ~/.vimrc
"
" Installed packages:
"   - Emmet     - https://github.com/mattn/emmet-vim
"   - NerdTree  - https://github.com/scrooloose/nerdtree
"   - Pathogen  - https://github.com/tpope/vim-pathogen
"   - Syntastic - https://github.com/vim-syntastic/syntastic
"
"   - vim-javascript - https://github.com/pangloss/vim-javascript
"   - vim-less       - https://github.com/groenewege/vim-less
"   - vim-pug        - https://github.com/digitaltoad/vim-pug
"
" Author: Ivan Bogachev <sfi0zy@gmail.com> (https://sfi0zy.github.io/), 2018
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

execute pathogen#infect()
call pathogen#helptags()



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Tabs & Spaces
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>' use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Line endings
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

autocmd BufWritePre * set ff=unix



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Navigation
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Show line numbers by default
set nu

" Open NERDTree automatically when vim starts up
autocmd vimenter * NERDTree
let NERDTreeShowHidden = 1



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Highlighting
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable syntax highlighting by default
syntax on

" Apply colorscheme
colorscheme atlantic-dark

" Highlight 80 and 120 columns
highlight ColorColumn ctermbg=232 guibg=#060606
let &colorcolumn="80,".join(range(120,999),",")

" Highlight search results
set hlsearch
set incsearch

" Highlight parens
set showmatch

" Highlight ES6 template strings
hi link javaScriptTemplateDelim  String
hi link javaScriptTemplateVar    Text
hi link javaScriptTemplateString String

" Now hyphens are part of identifiers
au! FileType css,less,html setl iskeyword+=-


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Auto completion
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable code completion
filetype plugin on
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS

" Activate omni on Tab
function! TabOrComplete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-X>\<C-O>"
    else
        return "\<Tab>"
    endif
endfunction

inoremap <Tab> <C-R>=TabOrComplete()<CR>

" Activate wildmenu
set wildmenu

" Change default trigger key for emmet
let g:user_emmet_leader_key = '<C-Z>'


" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Linters
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Settings for Syntastic (recommended)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0

" Eslint
let g:syntastic_javascript_checkers      = ['eslint']
let g:syntastic_javascript_eslint_exe    = 'npx eslint'
let g:syntastic_javascript_eslint_exec   = '/bin/ls'
let g:syntastic_javascript_eslint_args   = '--no-eslintrc --config ./.eslintrc'

