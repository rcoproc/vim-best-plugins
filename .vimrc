" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
"set autowrite                   "Grava automaticamente

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on
syntax enable
set background=dark

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif

" ================ Turn Off Swap Files ==============

"set noswapfile
"set nobackup
"set nowb

" Setting up the directories {
         set backup                      " backups are nice ...
         " Moved to function at bottom of the file
         set backupdir=$HOME/.vim.backup//  " but not when they clog .
         set directory=$HOME/.vimswap//     " Same for swap files
         set viewdir=$HOME/.vimviews//  " same for view files

         let g:WriteBackup_BackupDir='/Users/Ricardo/.vim.backup'
         let g:WriteBackup_AvoidIdenticalBackups = 1
         let g:WriteBackup_DiffShellCommand = '/Users/Ricardo/.vim.backup'

         "" Creating directories if they don't exist
         "silent execute '!mkdir -p $HVOME/.vimbackup'
         "silent execute '!mkdir -p $HOME/.vimswap'
         "silent execute '!mkdir -p $HOME/.vimviews'
         au BufWritePre * let &bex = '-' . strftime("%Y%m%d-%H%M%S") . '.vimbackup'
         au BufWinLeave \* silent! mkview  "make vim save view (state)
"(folds, cursor, etc)
         au BufWinEnter \* silent! loadview "make vim load view (state)
""(folds, cursor, etc)
     " }

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

" set foldmethod=syntax   "fold based on indent
" set foldnestmax=3       "deepest fold is 3 levels
" set nofoldenable        "dont fold by default

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za
" ================ Completion =======================

set wildmode=list:longest,full
"set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=*public*
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.cache
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim

set statusline=%{fugitive#statusline()}

set path =/Users/Ricardo/Documents/integragrp/tributario
set path+=/Users/Ricardo/Documents/RAILS/rails_rknet
set path+=lib/**,spec/**

set cursorline
set tags=/Users/Ricardo/Documents/integragrp/tributario,tags;

" Open NERDTree in VIM/MVIM startup
let g:nerdtree_tabs_open_on_console_startup=0
let NERDTreeShowLineNumbers=1
"let g:nerdtree_tabs_open_on_gui_startup = 1
let g:NERDTreeWinPos = "right"

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim-NERDTreeBookmarks")
" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Shortcut for NERDTree
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
nmap <C-X> :NERDTreeClose<cr>

" Shortcut for CTRL+SHIFT ( search files )
let g:ctrlp_map = '<C-S>'
let g:ctrlp_cmd = 'CtrlP'

set runtimepath^=~/.vim/bundle/ctrlp.vim

" :help ctrlp-commands
" When invoked, unless a starting directory is specified, CtrlP will set its local working directory according to this variable:
let g:ctrlp_working_path_mode = 'r' " ra faz a pesquisa no HOME
let g:ctrlp_by_filename = 0
" Open file in the current window
let g:ctrlp_open_new_file = 'r'


" Specify an external tool to use for listing files instead of using Vim's globpath(). Use %s in place of the target directory:
" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
let g:ctrlp_max_height=25
let g:ctrlp_follow_symlinks=0
"let g:ctrlp_working_path_mode = 0
let g:ctrlp_show_hidden = 0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_mruf_max = 250
let g:ctrlp_mruf_include = '\.js$\|\.rb$|\.erb$|\.haml$|\.slim$|\.txt$|\.html$'

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
  "let g:ctrlp_user_command = 'ag -l --nocolor -G %s'
  " ag -l --nocolor -G %s
  " let g:ctrlp_user_command = 'ag %s -l -G "%s" --nocolor'
  "
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0  

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m
endif

set vi='30,\"50,n~/.viminfo


" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

" , mw ( marca janela para mudança ) , ,pw ( muda a janela atual para a janela
"        marcada antes)
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Get current Path/FileName into clipboard
nmap <silent> <leader>cl :let @*=expand("%:p")<CR>    
" Get current FileName only
nmap <silent> <leader>cf :let @+=expand("%:t:r")<CR>

""""""" custom commands 
"clear highlights for a search
nnoremap <silent> <leader><space> :noh<CR>

"

" Called :once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

set selection=inclusive

" Ativa linhas coloridas nos marcadores;
let g:bookmark_highlight_lines = 1

" Configurando cores as ident guides
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

colorscheme solarized
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_termcolors=16
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
let g:solarized_diffmode="normal"
let g:solarized_hitrail=0
let g:solarized_menu=1

set guifont=Roboto\ Mono\ Medium\ for\ Powerline:h14
" set guifont=Source\ Code\ Pro\ for\ Powerline:h14
" set ts=2 sw=2 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Cursor Line and Columns Colors
hi CursorLine   cterm=NONE ctermbg=darkgreen ctermfg=white guibg=darkgreen guifg=white
hi CursorColum cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi Visual  guifg=#000000 guibg=#FFFFFF gui=none
nnoremap <Leader>C :set cursorline! cursorcolumn!<CR>

" Configuration for Airline StatusBar
" let g:airline_theme='papercolor'
" let g:airline_theme='molokai'
" let g:airline_theme='tomorrow'
" let g:airline_theme='lucius'
" let g:airline_theme='jellybeans'
" let g:airline_theme='papercolor'
" let g:airline_theme='badwolf'
" let g:airline_theme='jellybeans'
" let g:airline_theme='hybridline'
let g:airline_theme='bubblegum'
let g:airline_inactive_collapse=1
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#fnamemod =':t:r'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#hunks#non_zero_only = 0

" Show only filename in section c 
let g:airline_section_c = '%t'
" Hidden file type in Section X ( ruby, javascript , etc )
let g:airline_section_x = ''
" Hidden file type in Section Y ( utf-8 )
let g:airline_section_y = ''

"AirlineTheme papercolor(azul) ou molokai(laranjado)
"let AirlineToggleWhitespace
"
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" F2 Plugin List
map <F2> :PluginList<CR>

" F3 Open MRU Window
map <F3> :MRU<cr>

" F4 List open Tabs
map <F4> :tabs<cr>

" Mapeia o F5 para o Gundo
nnoremap <F5> :GundoToggle<CR>

" F6 List open Buffers
map <F6> :BufExplorer<CR>

" Open Explore
map <F9> :Explore ~/Documents/integragrp<CR>

" F10 TListOpen
map <F10> :TlistOpen<CR>

" F7 Open VIMRC
map <F11> :edit ~/.vimrc<CR>


" Configuration MBE(Mini Buffer Explorer)
" let g:miniBufExplorerAutoStart = 0

" Configuration MRU(Most recent files)
" let MRU_Filename_Format={'formatter':'v:val', 'parser':'.*'}
let MRU_Window_Height = 20
let MRU_Use_Current_Window = 1
let MRU_Max_Menu_Entries = 20

" Configuration for TagList
let Tlist_Sort_Type = "name"

" let g:UltiSnipsEnableSnipMate

let b:UltiSnipsSnippetDirectories=["/Users/Ricardo/.yadr/vim/bundle/vim-snippets/snippets"]
let g:UltiSnipsSnippetDirectories=["UltiSnips"]


" Plugin key-mappings NEOSNIPPET.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


" Configuration for Mate SNIPETS
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails,ruby-rails,Rails'

" nmap Configuration for Gi:tGutter
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk


" nmap Configuration for fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gd :Gvdiff<CR>

" Map para CtrlPFunky
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>


" Default mapping for Multi-Cursors
let g:multi_cursor_next_key='<C-.>'
let g:multi_cursor_prev_key='<C-,>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

let g:startify_skiplist = [
           \ '\.log',
           \ '\.bak'
           \ ]

" let g:startify_change_to_dir = 1
let g:ascii = [
                \ ':[<C-L> split window, [<C-N>] next Window, [C-P] previous Window, gc4j Comment/Uncomment, gx Open URI under cursor, :!open URI',
                \ ':MRU , :CtrlP , :TlistOpen,  :Startify , :AirlineToggle , :AirlineTheme lucius , :PluginList , :PluginInstall ',
                \ ':GStatus , GCommit, :GPush, :GDiff, :Gundo, :Ag texto --ruby , :EController payment , :EModel Person , :BOpen ',
                \ ':bufdo bd # Close All buffers', 
                \ '-----------------------------------------------------------------------------------------------------------------------',
                \ ':%s/\s\+$// # Remove trailing spaces, :%s/$/,/g # Acresc. final de linha com , :%s/^/INSERT /g  #Insere começo de linha',
                \ ':%s/\n/, /g # Substitui final de linha por ,  :.,$s/abc/cde/g # A partir da linha atual, :2,14s/abc/cde/g # Subs. das linhas 2 ao 14  gU ou gu (Upper ou Lower Case)',
                \ ':g/^$/d     #Limpa linhas em branco :h pattern e h range # Help de Patterns RegExp e dos Ranges' ]

" let g:startify_custom_header  = '[""]'
let g:startify_custom_header = 'map(startify#fortune#boxed() + g:ascii, "\"   \".v:val" )'

let g:startify_files_number = 13
let g:startify_custom_footer = [
                               \ "                                     More Util Information: http://rayninfo.co.uk/vimtips.html",
                               \ "                                     [,cl] Copy path/filename to clipboard [,cf] Copy only filename to clipboard",
                               \ "   by Ricardo Oliveira. ':Enjoy It'. [,,s] Find character [,cl] Get file Name [,mw] Mark Window [,pw] Change Window [,hu] Undo Hunk [,ig] Indent Guide",
                               \ "                                     [<F2>] Plugin list [<F3>] MRU [<F4>] Tabs [<F5>] Gundo |<F6>| Buffers [<F9:w Explorer[<F10>] TagList [<F11>] vimrc [,ne] NERDTree [<C-X>] Close NERDTree, *insert mode* [<C-o] 80i-<ESC>"]
let g:startify_change_to_vcs_root = 1

Plugin 'vim-scripts/ZoomWin'
Plugin 'Chun-Yang/vim-action-ag'
Plugin 'vim-scripts/ingo-library'
Plugin 'writebackup'
Plugin 'writebackupVersionControl'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'airblade/vim-gitgutter'
Plugin 'bonsaiben/bootstrap-snippets'
Plugin 'yegappan/mru'
Plugin 'vim-scripts/UltiSnips'
Plugin 'ap/vim-css-color'
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/loremipsum'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'mhinz/vim-signify'
Plugin 'mhinz/vim-startify'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/taglist.vim'
Plugin 'zhaocai/GoldenView.Vim'
Plugin 'troydm/shellasync.vim'
Plugin 'blueyed/vim-diminactive'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'rizzatti/dash.vim'
" Plugin 'ryanoasis/vim-devicons'

set encoding=utf8

" NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
" exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction
"
" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('rb', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
" "
" let g:webdevicons_conceal_nerdtree_brackets = 0
" " " let g:webdevicons_enable_flagship_statusline = 0
" " " let g:WebDevIwconsUnicodeDecorateFileNodesExtensionSymbols = {}
" "
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = '🚴'
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ' JS'
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rb'] = ' RB '
" let g:WebDevIconsUnicoodeDecorateFileNodesExtensionSymbols['css'] = 'CSS'
" let g:WebDevIconsUnicoodeDecorateFileNodesExtensionSymbols['dump'] = '№'
" let g:DevIconsDefaultFolderOpenSymbol = '>>'

"
" let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ' '

" Uncomment the following to have Vim jump to the last position when
" reopening a file:
if has("autocmd")
  " au!
  "au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  "au BufWinLeave *.rb mkview
  "au BufWinEnter *.rb silent loadview
  " Reabre o VIM com o Airline configurado corretamente
  " Mais informações em:
  " http://www.ibm.com/developerworks/library/l-vim-script-5/
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
  au BufWinEnter * silent AirlineToggleWhitespace
  au BufWinEnter * silent AirlineToggle
  au BufWinEnter * silent AirlineToggle
  au BufEnter *.rb silent UltiSnipsAddFiletypes ruby
  au BufEnter *.rb silent UltiSnipsAddFiletypes rails
end

cd /Users/Ricardo/Documents/adam/adamsc
" cd /Users/Ricardo/Documents/RAILS/RKSNET/academias
" cd /Users/Ricardo/Documents/RAILS/Photogram

