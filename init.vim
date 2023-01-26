silent! call plug#begin(stdpath('data') . '/plugged')
	Plug 'numToStr/Comment.nvim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'untitled-ai/jupyter_ascending.vim'
	Plug 'preservim/nerdtree'
	Plug 'sansyrox/vim-python-virtualenv'
	Plug 'kshenoy/vim-signature'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'reedes/vim-pencil'
	Plug 'tpope/vim-fugitive'
	Plug 'stevearc/vim-arduino'
	" Plug 'junegunn/seoul256.vim'
	Plug 'sonph/onehalf', { 'rtp' : 'vim' }
call plug#end()
lua require('Comment').setup()

" let g:airline_theme='onedark'
let g:pyindent_open_paren=shiftwidth()
let g:netrw_banner=0
" set clipboard+=unnamedplus

" indents
set smartindent
set tabstop=4
set shiftwidth=4

" visuals
set relativenumber
set number
set scrolloff=999
set cursorline
hi CursorLine   cterm=NONE ctermbg=237 ctermfg=NONE
hi MatchParen ctermbg=241
hi CursorLineNr cterm=NONE
set list
set listchars=lead:·,trail:·,tab:>·
hi Whitespace ctermfg=024
" alternatively this is uncommented and we have light theme
colorscheme onehalfdark

" do an operator on every line in the file (daG, yaG, =aG)
xnoremap aG ggoG
onoremap aG :normal VaG<cr>

" move lines
nnoremap <A-j> :m .+1<CR>
nnoremap <A-k> :m .-2<CR>
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nmap <C-z> :echo "This isnt atom my boi"<CR>
inoremap ii <Esc>

set backupdir=~\AppData\Local\nvim-data\backup\\

" leader kommandoer
let mapleader=" "

" clipboard
nnoremap <leader>p "+p
nnoremap <leader>y "+y

" git stuff
nnoremap <leader>gc :!git commit -am 
nnoremap <leader>gp :!git push<CR>
nnoremap <leader>gg :!git pull<CR>
nnoremap <Enter> :noh<CR>
" move mellom splits
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>b :!black % <CR>
nnoremap <leader>f 0f(af"{<ESC>$i=}"<ESC>
" move mellom tabs
nnoremap H gT
nnoremap L gt
" aapne tabs og splits
nnoremap <leader>t :tabnew 
nnoremap <leader>v :vsplit 
" search and replace
nnoremap <leader>s :%s///g<Left><Left>
" bedre shift yank
map Y y$
""""""""""""" Her maa de legges til conditional execution --------------
nnoremap <leader>n :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:python3_host_prog='/usr/bin/python3'
autocmd FileType python let b:coc_diagnostic_disable=1
" hardmode
noremap <Up> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Down> <Nop>

inoremap <Up> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Down> <Nop>

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
"----------------COCOOCOCOC----------------------


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

highlight CocMenuSel ctermbg=252

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" bogo solution for inlayhints
highlight CocInlayHint ctermfg=236

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.


"" ------- python --------
autocmd FileType python map <buffer> <C-b> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-b> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" ------- latex ---------
autocmd FileType tex map <buffer> <C-b> :w<CR>:exec '!pdflatex % && zathura %<.pdf&'<CR>
autocmd FileType tex imap <buffer> <C-b> <esc>:w<CR>:exec '!pdflatex % && zathura %<.pdf&'<CR>

" --------- C -----------
autocmd FileType c map <buffer> <C-b> :w<CR>:!gcc -g -Wall -Wextra -std=gnu11 % -o %< && ./%<<CR>
autocmd FileType c imap <buffer> <C-b> <esc> :w<CR>:!gcc -g -Wall -Wextra -std=gnu11 % -o %< && ./%<<CR>

" --------- C++ ---------
autocmd FileType cpp map <buffer> <C-b> :w<CR>:!g++ % && ./a.out<CR>
autocmd FileType cpp imap <buffer> <C-b> <esc> :w<CR>:!g++ % -o %< && ./%<<CR>

" -------- Java ---------
autocmd FileType java map <buffer> <C-b> :w<CR>:exec '!javac *.java && java %<'<CR>
autocmd FileType java imap <buffer> <C-b> <esc> :w<CR>:!javac *.java && java %<<CR>

" -------- VHDL ---------
autocmd FileType vhdl set expandtab
autocmd FileType vhdl set shiftwidth=2
" -------- notebook ---------
nnoremap <C-Enter> :w<CR>:exec '!python -m jupyter_ascending.requests.sync --filename %'<CR>
nnoremap <C-j> :w<CR>:exec '!python -m jupyter_ascending.requests.sync --filename %'<CR>

set undodir=$XDG_CONFIG_HOME/nvim/undo_dir
set undofile
