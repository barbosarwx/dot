" tested in v:version >= 800

" no vi mimic
set nocompatible

" case-insensitive searches
set ignorecase

" automatically indent new lines
set autoindent

" avoid losing changes
set autowrite

" cursor current position, line number and col number
set ruler "see ruf for formating
set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" deactivate line numbers
set nonumber

" quickly confirm which mode you are in
set showmode

" spaces ftw, tabstop is visual, softtab determines how many spaces
set softtabstop=2
set tabstop=2

" replace tabs with spaces automatically
set expandtab

" no bell, no flash
set t_vb=

" sets the number of spaces that Vim uses for each level of indentation when you press the Tab key
set shiftwidth=2

" a example is indenting after an opening curly brace
set smartindent

" causes Vim to use a mixture of spaces and tabs for indentation to optimize the alignment of code
set smarttab

" stop vim from silently messing with files that it shouldn't
set nofixendofline

" show special characters, such as spaces, tabs etc
set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

" the folds are automatically defined by the indent of the lines.
set foldmethod=indent
"set nofoldenable "disable automatic folding, when opening a file

" highlight trailing whitespace at the end of lines
match IncSearch '\s\+$'

" automatically wrapping text at a specific column
set textwidth=72

" helpful for visually indicating a specific column in your text
"set colorcolumn=73

" make each line has a unique, absolute line number
set norelativenumber

" turn off default spell-checking
set nospell

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

" enables highlighting of search results as you type
set hlsearch

" immediately start searching and highlighting matches as you type
set incsearch

" disable search highlighting with <C-L> when refreshing screen
nnoremap <C-L> :nohl<CR><C-L>

" helps prevent lines from extending beyond the edge of the screen
set linebreak

" avoid most of the 'Hit Enter ...' messages
"set shortmess=aoOtTI

" configure how Vim manages and stores its history and internal state
set viminfo='20,<1000,s1000

" wrap around when searching
set wrapscan
set nowrap

" command history
set history=100

" here because plugins and stuff need it
syntax enable

" faster scrolling
set ttyfast

" automatically detecting file types and applying the appropriate settings and plugins for those file types
filetype plugin on

" high contrast
set background=dark

" make gutter (number columm) transparent
hi SignColumn ctermbg=NONE

" base default color changes gruvbox dark friendly
"hi StatusLine ctermfg=black ctermbg=NONE
"hi StatusLineNC ctermfg=black ctermbg=NONE
"hi Normal ctermbg=NONE
"hi Special ctermfg=cyan
"hi LineNr ctermfg=black ctermbg=NONE
"hi SpecialKey ctermfg=black ctermbg=NONE
"hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
"hi MoreMsg ctermfg=black ctermbg=NONE
"hi NonText ctermfg=black ctermbg=NONE
"hi vimGlobal ctermfg=black ctermbg=NONE
"hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
"hi Error ctermbg=234 ctermfg=darkred cterm=NONE

hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE

hi Search ctermbg=236 ctermfg=yellow
hi Todo ctermbg=236 ctermfg=darkgreen
hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
hi MatchParen ctermbg=236 ctermfg=darkred


" color overrides
au FileType * hi StatusLine ctermfg=black ctermbg=NONE
au FileType * hi StatusLineNC ctermfg=black ctermbg=NONE
au FileType * hi Normal ctermbg=NONE
au FileType * hi Special ctermfg=cyan
au FileType * hi LineNr ctermfg=black ctermbg=NONE
au FileType * hi SpecialKey ctermfg=black ctermbg=NONE
au FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
au FileType * hi MoreMsg ctermfg=black ctermbg=NONE
au FileType * hi NonText ctermfg=black ctermbg=NONE
au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
au FileType * hi goComment ctermfg=black ctermbg=NONE
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred

au FileType markdown,pandoc hi Title ctermfg=darkblue ctermbg=NONE
au FileType markdown,pandoc hi Operator ctermfg=darkblue ctermbg=NONE
au FileType markdown,pandoc set tw=0
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE

" file type settings
au FileType yaml set sw=2
"au FileType bash set sw=2
au FileType * set sw=2
au FileType markdown,pandoc noremap j gj
au FileType markdown,pandoc noremap k gk
"au FileType sh set noet

" only load plugins if Plug detected " github.com/junegunn/vim-plug
" reload file before PlugInstall
if filereadable(expand("~/.vim/autoload/plug.vim"))

  call plug#begin('~/.local/share/vim/plugins')
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'vim-pandoc/vim-pandoc' "https://github.com/neovim/neovim/issues/2102 -- install-utf8 script
  Plug 'rwxrob/vim-pandoc-syntax-simple' "Because colors and hash instead of section sign character §.
  Plug 'nordtheme/vim'
  Plug 'morhetz/gruvbox'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'dense-analysis/ale' "Asynchronous Lint Engine
  Plug 'hashivim/vim-terraform'
  Plug 'tpope/vim-fugitive'
  Plug 'github/copilot.vim'
  call plug#end()

  colorscheme nord
  "colorscheme gruvbox

  " ale
  let g:ale_lint_on_save = 1
  let g:ale_set_highlights = 1
  let g:ale_sign_error = '☠'
  let g:ale_sign_warning = '⚠'
  let g:ale_linters = {'go': ['golangci-lint','gofmt','gobuild'],
        \              'terraform': ['terraform','tflint','tfsec'],
        \              'json': ['biome'],
        \              'yaml': ['yamllint'],
        \}
" `*` works for all file types, except the listed below
  let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'],
        \             'terraform': ['terraform','remove_trailing_lines', 'trim_whitespace'],
        \             'json': ['biome','remove_trailing_lines', 'trim_whitespace'],
        \             'yaml': ['yamlfmt','remove_trailing_lines', 'trim_whitespace'],
        \}
  " show style issues
  let g:ale_vim_vint_show_style_issues = 1

  " terraform
  let g:terraform_align = 1
  "let g:terraform_fmt_on_save = 1
  let g:hcl_align = 1

  " pandoc
  let g:pandoc#formatting#mode = 'h' " A'
  let g:pandoc#formatting#textwidth = 72
  " pandoc spell
  let g:pandoc#spell#enabled = 0
  let g:pandoc#spell#default_langs = ['pt', 'en']

  " golang
  let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_autosave = 1
  let g:go_gopls_enabled = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1
  "let g:go_auto_type_info = 1 " forces 'Press ENTER' too much
  let g:go_auto_sameids = 0
  "time delay in milliseconds for triggering various automatic updates, such as cursorline, cursorcolumn, and others.
  set updatetime=100
  "let g:go_gopls_analyses = { 'composites' : v:false }
  "press \something to insert text
  "au FileType go nmap <leader>m ilog.Print("made")<CR><ESC>
  "au FileType go nmap <leader>n iif err != nil {return err}<CR><ESC>
else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
endif

" force loclist to always close when buffer does (affects vim-go, etc.)
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

"enhances the command-line completion and navigation experience in Vim
set wildmenu

" enable omni-completion
set omnifunc=syntaxcomplete#Complete

" force some files to be specific file type
au bufnewfile,bufRead user-data set ft=yaml
au bufnewfile,bufRead meta-data set ft=yaml
au bufnewfile,bufRead *.ddl set ft=sql
au bufnewfile,bufRead *.bash* set ft=bash
au bufnewfile,bufRead *.gotmpl set ft=go
au bufnewfile,bufRead *.profile set filetype=sh
au bufnewfile,bufRead *.crontab set filetype=crontab
au bufnewfile,bufRead *ssh/config set filetype=sshconfig
au bufnewfile,bufRead .dockerignore set filetype=gitignore
au bufnewfile,bufRead *gitconfig set filetype=gitconfig
"au bufnewfile,bufRead *.go set spell spellcapcheck=0
"au bufnewfile,bufRead commands.yaml set spell
"au bufnewfile,bufRead *.txt set spell
au bufnewfile,bufRead *.tf set filetype=terraform
au bufnewfile,bufRead *.hcl set filetype=terraform
au bufnewfile,bufRead *.dsl set filetype=groovy
au bufnewfile,bufRead *.md set filetype=pandoc

au BufNewFile,BufRead *.yaml,*.yml so $DOTFILES/yaml.vim

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
map <F1> :set number!<CR> :set relativenumber!<CR>
nmap <F2> :echo expand('%:p')<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>
map <F8> :ALEFix<CR>

nmap <leader>2 :set paste<CR>i

" disable arrow keys (vi muscle memory)
" noremap <up> :echoerr "Umm, use k instead"<CR>
" noremap <down> :echoerr "Umm, use j instead"<CR>
" noremap <left> :echoerr "Umm, use h instead"<CR>
" noremap <right> :echoerr "Umm, use l instead"<CR>
" inoremap <up> <NOP>
" inoremap <down> <NOP>
" inoremap <left> <NOP>
" inoremap <right> <NOP>

" better use of arrow keys, number increment/decrement
" nnoremap <up> <C-a>
" nnoremap <down> <C-x>

" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>

"augroup EmojiConversion
"    autocmd!
"    autocmd BufWritePost *.{md,adoc} execute 'silent !toemoji %' | edit!
"augroup END

"preserves cursor location when toemoji conversion runs on save
augroup EmojiConversion
    autocmd!
    autocmd BufWritePost *.{md,adoc} let save_cursor = getpos(".") | execute 'silent !toemoji %' | edit! | call setpos('.', save_cursor)
augroup END
