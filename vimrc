" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
" ~/.vimrc
"
" Installed packages:
"   - Pathogen            - https://github.com/tpope/vim-pathogen
"   - Editorconfig        - https://github.com/editorconfig/editorconfig-vim
"   - Emmet               - https://github.com/mattn/emmet-vim
"   - NerdTree            - https://github.com/scrooloose/nerdtree
"   - Syntastic           - https://github.com/vim-syntastic/syntastic
"   - indentLine          - https://github.com/Yggdroot/indentLine
"   - vim-grammarous      - https://github.com/rhysd/vim-grammarous
"   - vim-multiple-cusors - https://github.com/terryma/vim-multiple-cursors
"   - vim-airline         - https://github.com/vim-airline/vim-airline
"   - vim-airline-themes  - https://github.com/vim-airline/vim-airline-themes
"   - vim-javascript      - https://github.com/pangloss/vim-javascript
"   - vim-less            - https://github.com/groenewege/vim-less
"   - vim-pug             - https://github.com/digitaltoad/vim-pug
"   - vim-liquid          - https://github.com/tpope/vim-liquid
"
" Installed color schemes:
"   - atlantic-dark       - https://github.com/sfi0zy/atlantic-dark.vim
"
" Author: Ivan Bogachev <sfi0zy@gmail.com>, 2018-2020
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

execute pathogen#infect()
call pathogen#helptags()


" Find the directory where 'vim' command was executed
" We use it to load configs from root directory of project where vim session
" is working, not from subdirectories of it.
function FindSessionDirectory() abort
    if len(argv()) > 0
        return fnamemodify(argv()[0], ':p:h')
    endif
    return getcwd()
endfunction!



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Tabs & Spaces
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>' use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Set color for vertical lines (indentations)
let g:indentLine_color_term = 236

" Remove trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e


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

" Sets the current directory to skip %:h/ in the commands
:set autochdir


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Highlighting
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Enable syntax highlighting by default
syntax on


" Disable highlighting on long lines (improves performance)
set synmaxcol=120


" Apply colorscheme
colorscheme atlantic-dark
let g:airline_theme='term'

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


" Disable auto comments
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
let g:syntastic_javascript_eslint_exe    = 'npx --no-install eslint'
let g:syntastic_javascript_eslint_exec   = '/bin/ls'
let g:syntastic_javascript_eslint_args   = '--config ' . FindSessionDirectory() . '/.eslintrc'

" Stylelint
let g:syntastic_css_checkers             = ['stylelint']
let g:syntastic_css_stylelint_exe        = 'npx --no-install stylelint'
let g:syntastic_css_stylelint_exec       = '/bin/ls'
let g:syntastic_css_stylelint_args       = '--config ' . FindSessionDirectory() . '/.stylelintrc'

let g:syntastic_less_checkers            = ['stylelint']
let g:syntastic_less_stylelint_exe       = 'npx --no-install stylelint'
let g:syntastic_less_stylelint_exec      = '/bin/ls'
let g:syntastic_less_stylelint_args      = '--config ' . FindSessionDirectory() . '/.stylelintrc'

let g:airline#extensions#syntastic#enabled = 1




" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"  Others
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Disable indentLine for json files and show the quotes in them.
let g:vim_json_syntax_conceal = 0
autocmd Filetype json let g:indentLine_enabled = 0

