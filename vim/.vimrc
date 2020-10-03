if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  Plug 'rbgrouleff/bclose.vim'
  Plug 'SirVer/ultisnips'

  Plug 'tmux-plugins/vim-tmux'
  Plug 'liuchengxu/vista.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'Shougo/echodoc.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'omnisharp/omnisharp-vim'

  Plug 'honza/vim-snippets'

  Plug 'godlygeek/tabular'
  Plug 'lepture/vim-jinja'

  Plug 'ntpeters/vim-better-whitespace' " Better display unwanted whitespace.
  Plug 'jiangmiao/auto-pairs'

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'melonmanchan/vim-tmux-resizer'

  Plug 'vimwiki/vimwiki',

  Plug 'majutsushi/tagbar' " Class outline viewer

  Plug 'thinca/vim-localrc'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'gruvbox-community/gruvbox'
  Plug 'arcticicestudio/nord-vim'

  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'

  Plug 'terryma/vim-multiple-cursors'
  Plug 'airblade/vim-gitgutter'

  Plug 'sheerun/vim-polyglot' " A solid language pack for Vim.
  Plug 'shime/vim-livedown' " Live preview for markdown

  Plug 'tpope/vim-sleuth' " Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
  Plug 'tpope/vim-sensible' " Sane defaults
  Plug 'tpope/vim-repeat' " Repeat plugin commands
  Plug 'tpope/vim-commentary' " Toggle comment blocks
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'

  Plug 'psliwka/vim-smoothie' " Smooth scrolling with <C-u> and <C-d>

  Plug 'ryanoasis/vim-devicons' " Fancy icons for files. Should be loaded last

  Plug 'mhinz/vim-startify'
  Plug 'voldikss/vim-floaterm'
  Plug 'junegunn/goyo.vim'
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-floaterm',
  \ 'coc-fzf-preview',
  \ 'coc-git',
  \ 'coc-highlight',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-metals',
  \ 'coc-omnisharp',
  \ 'coc-powershell',
  \ 'coc-python',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-sql',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ ]

let g:vimwiki_list = [{'path': '~/vimwiki/', 'path_html': '~/vimwiki_html/'}]

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

autocmd FileType helm setlocal commentstring=#\ %s

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" complete with tab
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger = '<leader-tab>'

" Omnisharp
let g:OmniSharp_highlighting = 3
let g:omnicomplete_fetch_full_documentation = 1
" Use fzf.vim"
let g:OmniSharp_selector_ui = 'fzf'
" let g:OmniSharp_popup = 1
let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_popup_options = {
" \ 'wrap': v:true,
" \ 'winblend': 30,
" \ 'winhl': 'Normal:Normal'
" \}

let g:OmniSharp_diagnostic_exclude_paths = [
\ 'obj\\',
\ '[Tt]emp\\',
\ '\.nuget\\'
\]

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup
    " autocmd CursorHold *.cs OmniSharpSignatureHelp

    autocmd FileType cs nnoremap <Leader>kd :OmniSharpCodeFormat<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <C-space> :OmniSharpGetCodeActions<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    " autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    " autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Explorer
nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" tmux resizing
" maps to alt (hjkl)
nnoremap <silent> ˙ :TmuxResizeLeft<cr>
nnoremap <silent> ∆ :TmuxResizeDown<cr>
nnoremap <silent> ˚ :TmuxResizeUp<cr>
nnoremap <silent> ¬ :TmuxResizeRight<cr>


imap jj <Esc>
let mapleader = ',' " remap leader to ,

let g:strip_whitespace_on_save=1 " remove trailing whitespace on write

 " only run vimwiki in vimwiki dir
let g:vimwiki_global_ext = 0
let g:vimwiki_listsyms = '✗○◐●✓'

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:loaded_python_provider = 1 " disable python2
let g:python3_host_prog = '/usr/bin/python'


autocmd FileType json setlocal shiftwidth=2 tabstop=2
autocmd FileType yml,yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType vimwiki setlocal shiftwidth=2 tabstop=2
autocmd FileType sql setlocal shiftwidth=4 tabstop=4

" au BufNewFile,BufRead *.sql set ft=dbt
au BufNewFile,BufRead Dockerfile*.tpl set ft=Dockerfile
au BufNewFile,BufRead *.yml.tpl set ft=yaml
au BufNewFile,BufRead *.yaml.tpl set ft=yaml


" ctrl-r replace in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Esc for terminal in nvim
tnoremap <Esc> <C-\><C-n>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


" Split buffer vertically with vb
cabbrev vb vert sb
" Split buffer vertically on the right with vbr
cabbrev vbr vert belowright sb

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

" lightline-bufferline configuration
let g:lightline#bufferline = {
      \ 'show_number': 1,
      \ 'shorten_path': 1,
      \ 'unnamed': '[No Name]',
      \ 'filename_modifier': '.',
      \ 'enable_devicons': 1
      \ }


let g:lightline = {
      \ 'tabline': {'left': [['buffers']], 'right': [['close']]},
      \ 'component_expand': {'buffers': 'lightline#bufferline#buffers'},
      \ 'colorscheme': 'gruvbox',
      \ 'component_type': { 'buffers': 'tabsel' },
      \ 'active': { 'left':  [ [ 'mode', 'paste' ],
      \                        [ 'cocstatus',  'currentfunction', 'readonly', 'filename', 'modified', 'gitbranch'] ]
      \ },
      \ 'component_function': {
      \         'gitbranch': 'FugitiveHead',
      \         'cocstatus': 'coc#status',
      \         'currentfunction': 'CocCurrentFunction'
      \ }
      \}

set nowrap
filetype plugin on
set lazyredraw

set relativenumber " relative line numbers
set number              " Show number
set guicursor= " set nvim cursor to bar (or rather unset the I-beam)

" remove delay when exiting vim
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

set showtabline=2  " always show tabline
set noshowmode
set laststatus=2
set termguicolors       " Enable true color
set encoding=UTF-8 " set encoding to utf-8 for vim-devicons
set hidden " Keep files open without displaying them on screen

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

colorscheme gruvbox

let test#python#runner = 'pytest'

" match omments in json
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:plug_window = 'noautocmd vertical topleft new'

inoremap <C-e> <Esc>:TREPLSendLine<CR>
nnoremap <C-e> :TREPLSendLine<CR>i
xnoremap <C-e> :'<,'>TREPLSendSelection<CR>

"Switch between different windows by their direction`
" no <C-j> <C-w>j| "switching to below window
" no <C-k> <C-w>k| "switching to above window
" no <C-l> <C-w>l| "switching to right window
" no <C-h> <C-w>h| "switching to left window

let g:ranger_replace_netrw = 1 "// open ranger when vim open a directory

" remap fzf to ;
" map ; :Files<CR>
map ; :FloatermNew fzf<CR>
map <C-B> :Lines<CR>

nnoremap <leader>bt :BTags<CR>
nnoremap <leader>lt :Tags<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>lb :Buffers<CR>
nnoremap <leader>gf :GFiles<CR>
nnoremap <leader>gsf :GFiles?<CR>

" delete buffer with <C-x>
nnoremap <C-x> :bd<CR>

" Floaterm
noremap  <leader>t  :FloatermToggle<CR>
noremap! <leader>t  <Esc>:FloatermToggle<CR>
tnoremap <leader>t  <C-\><C-n>:FloatermToggle<CR>

let g:floaterm_width = 100
let g:floaterm_winblend = 0

" Zoom
function! s:zoom()
 if winnr('$') > 1
   tab split
 elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
       \ 'index(v:val, '.bufnr('').') >= 0')) > 1
   tabclose
 endif
endfunction

nnoremap <silent> <leader>z :call <sid>zoom()<cr>

""" COC """
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


verbose nnoremap <Leader>ff :Format<CR>
