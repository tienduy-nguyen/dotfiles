" vim-bootstrap 2020-12-12 11:45:42

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/./autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "go,html,javascript,python,ruby,typescript"
let g:vim_bootstrap_editor = ""				" nvim or vim
let g:vim_bootstrap_theme = "codedark"
let g:vim_bootstrap_frams = "vuejs"

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif




" Required:
call plug#begin(expand('~/./plugged'))
    "" Files, folder tree
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    " COLORS, PRETTY & FUN
    Plug 'sheerun/vim-polyglot'
    Plug 'itchyny/lightline.vim'

    " MOVING AROUND
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'justinmk/vim-sneak'
    Plug 'easymotion/vim-easymotion'

    " ESSENTIAL
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-scripts/The-NERD-Commenter'
    " Git 
    Plug 'airblade/vim-gitgutter'
    Plug 'itchyny/vim-gitbranch'
    " PROSE & WRITING
    Plug 'junegunn/goyo.vim' " Focus more on code
    Plug 'reedes/vim-pencil'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'arthurxavierx/vim-unicoder'
    Plug 'psliwka/vim-smoothie'
    " NEXT LEVEL SHIT
    Plug 'mhinz/vim-grepper'
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    " Show the structure of the file
    Plug 'preservim/tagbar'
    " Tmux
    Plug 'christoomey/vim-tmux-navigator'
    " Low-key messes everything up
    Plug 'Yggdroot/indentLine'


    "" Color theme
    Plug 'haishanh/night-owl.vim'
    Plug 'Rigellute/shades-of-purple.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'voldikss/vim-floaterm'



"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" go
"" Go Lang Bundle
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}


" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'


" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax'


" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'


" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'


" vuejs
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'

" Icons for folders tree
" Work with nerd tree & nerd font
Plug 'ryanoasis/vim-devicons'

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.rc.local.bundles"))
  source ~/.rc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on


"----------------------------------------------------------------------
"                       Sneakin'
"----------------------------------------------------------------------
" Use the s character to traverse the the next ocurrence of sneak
  let g:sneak#s_next = 1

"----------------------------------------------------------------------
"                       FZF
"----------------------------------------------------------------------
" :Files<CR>
" :Rg<CR>
" :BLines<CR>
" :Marks<CR>
" :Commits<CR>
" :Helptags<CR>
" :<CR>
" :History/<CR>

" FZF to Ctrl+f
    nnoremap <C-b> :Buffers<CR>
    nnoremap <C-f> :Files<CR>
    nnoremap <C-p> :GFiles<CR>
    nnoremap <C-c> :History<CR>

    let $FZF_DEFAULT_OPTS = '--layout=reverse'

    let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

    function! OpenFloatingWin()
      let height = &lines - 3
      let width = float2nr(&columns - (&columns * 2 / 10))
      let col = float2nr((&columns - width) / 2)

      let opts = {
            \ 'relative': 'editor',
            \ 'row': height * 0.3,
            \ 'col': col + 30,
            \ 'width': width * 2 / 3,
            \ 'height': height / 2
            \ }

      let buf = nvim_create_buf(v:false, v:true)
      let win = nvim_open_win(buf, v:true, opts)

      call setwinvar(win, '&winhl', 'Normal:Pmenu')

      setlocal
            \ buftype=nofile
            \ nobuflisted
            \ bufhidden=hide
            \ nonumber
            \ norelativenumber
            \ signcolumn=no
    endfunction


"----------------------------------------------------------------------
"                       Vim-Grepper
"----------------------------------------------------------------------

" Grepper with <leader>g
    nnoremap <leader>g :Grepper<cr>
    let g:grepper = { 'next_tool': '<leader>g' }
    let g:grepper.tools=["rg"]

    xmap gr <plug>(GrepperOperator)
" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
    nnoremap <leader>R
      \ :let @s='\<'.expand('<cword>').'\>'<CR>
      \ :Grepper -cword -noprompt<CR>
      \ :cfdo %s/<C-r>s//g \| update
      \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
    xmap <Leader>R
        \ "sy
        \ gvgr2020-12-13
        \ :cfdo %s/<C-r>s//g \| update
         \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>



"*****************************************************************************
"" Visual Settings
"*****************************************************************************
let no_buffers_menu=1


" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" colorscheme rigel
" colorscheme codedark
" colorscheme onedark

" True color support for vim-one
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" let g:airline_theme='one'
" colorscheme one
" set background=dark  " for the dark version
colorscheme night-owl




if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
  
endif


if &term =~ '256color'
  set t_ut=
endif



" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv




"----------------------------------------------------------------------
"                       Lightline
"----------------------------------------------------------------------
    function! CocCurrentFunction()
        return get(b:, 'coc_current_function', '')
    endfunction

    let g:lightline = {
          \ 'colorscheme': 'nightowl',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'gitbranch','cocstatus', 'readonly', 'relativepath', 'modified', 'method'] ],
          \ 'right': [ [ 'lineinfo' ],
          \            [ 'percent' ],
          \            [ 'fileformat', 'fileencoding', 'filetype' ] ] 
          \ },
          \ 'component_function': {
          \   'gitbranch': 'gitbranch#name',
          \   'method': 'NearestMethodOrFunction',
          \   'cocstatus': 'coc#status',
          \ }
          \ }

    "set showtabline=2 "Always show tabline for bufferline on top

"----------------------------------------------------------------------
"                   Markdown Preview
"----------------------------------------------------------------------
    let g:mkdp_open_to_the_world = 1        " Markdown preview to the world

"----------------------------------------------------------------------
"                   GOYO && PENCIL WRITING
"----------------------------------------------------------------------

" Goyo start Writing!
    nnoremap <leader>G :Goyo<CR>

    let g:pencil_higher_contrast_ui = 1   " 0=low (def), 1=high
    "let g:limelight_default_coefficient = 0.7
    "let g:limelight_paragraph_span = 1
    let g:pencil#wrapModeDefault = 'soft'   " default is 'hard
    let g:pencil_terminal_italics = 1 " Support italics bc i'm dumb



" GOYO start!
    function! s:goyo_enter()
        let b:quitting = 0
        let b:quitting_bang = 0
        autocmd QuitPre <buffer> let b:quitting = 1
        cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
        Goyo 80
          if executable('tmux') && strlen($TMUX)
            silent !tmux set status off
            silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
          endif
        set noshowmode
        set noshowcmd
        set spell
        "set scrolloff=999
        set background=dark
        "Limelight
        unmap <leader>j
        TogglePencil
        colorscheme pencil
        syntax off
        syntax on
        "set conceallevel=2

    endfunction


" Let GOYO quit
    function! s:goyo_leave()
          if executable('tmux') && strlen($TMUX)
            silent !tmux set status on
            silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
          endif

          " Quit Vim if this is the only remaining buffer
          if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
            if b:quitting_bang
              qa!
            else
              qa
            endif
          endif
        endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()



"----------------------------------------------------------------------
"                       Indent-Line
"----------------------------------------------------------------------
    let g:indentLine_char = '▏'             " Show Indentation lines
    let g:indentLine_color_gui = '#474747'  " Make them pretty-gray-lines
    let g:indentLine_enabled = 0            " Just toggle this shit bro

    autocmd BufNew,BufEnter *.md,*.markdown,*.wiki execute "set conceallevel=0"
    autocmd BufNew,BufEnter *.html,*.css, execute "IndentLinesToggle"

"----------------------------------------------------------------------
"                       CocNVIM
"----------------------------------------------------------------------
" Remap Format prettier file to
    nnoremap ,f :CocCommand prettier.formatFile<CR>

"Format Prettier coc-extension -> :Prettier on current buffer
    command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Better display for messages
    set cmdheight=1
" Smaller updatetime for CursorHold & CursorHoldI
    set updatetime=1500
" don't give |ins-completion-menu| messages.
    set shortmess+=c
" always show signcolumns
    set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
    nnoremap <silent> ,K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

" Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
    vmap <leader>F  <Plug>(coc-format-selected)
    nmap <leader>F  <Plug>(coc-format-selected)
" Show all diagnostics
    nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
" Manage extensions
    nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
" Show commands
    nnoremap <silent> ,c  :<C-u>CocList commands<cr>
" Find symbol of current document
    nnoremap <silent> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols
    nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
    nnoremap <silent> ,j  :<C-u>CocNext<CR>
" Do default action for previous item.
    nnoremap <silent> ,k  :<C-u>CocPrev<CR>
" Resume latest coc list
    nnoremap <silent> ,p  :<C-u>CocListResume<CR>

" Turn off COC IN MARKDOWN
    autocmd BufNew,BufEnter *.md,*.markdown,*.wiki execute "silent! CocDisable"




"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 32
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <F2> :NERDTreeFind<CR>
nnoremap <F3> :NERDTreeToggle<CR>


vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nmap <Leader>w <plug>NERDCommenterToggle


"open NERDTree automatically
autocmd StdinReadPre * let s:std_in=0
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",
    \ "Modified"  : "#d9bf91",
    \ "Renamed"   : "#51C9FC",
    \ "Untracked" : "#FCE77C",
    \ "Unmerged"  : "#FC51E6",
    \ "Dirty"     : "#FFBD61",
    \ "Clean"     : "#87939A",
    \ "Ignored"   : "#808080"
    \ }


"**********************************************
" Shortcut for Floatern: multi terminal from vim
" ***************************************
""" Floatterm 
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
"" let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F9>'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
nnoremap   <silent>   <F9>   :FloatermToggle<CR>

" Easymotion
let g:EasyMotion_smartcase = 1
map <leader><leader>. <Plug>(easymotion-repeat)
map <leader><leader>f <Plug>(easymotion-overwin-f)
map <leader><leader>j <Plug>(easymotion-overwin-line)
map <leader><leader>k <Plug>(easymotion-overwin-line)
map <leader><leader>w <Plug>(easymotion-overwin-w)

" Tagbar
nmap <F12> :TagbarToggle<CR>
nmap <A-t> :TagbarToggle<CR>

" Generate new tagbar types with :TagBarGetTypeConfig <lang> 
" Open tagbar with F8

let g:tagbar_type_rust = {
            \ 'kinds' : [
            \ 'n:module:1:0',
            \ 's:struct',
            \ 'i:trait',
            \ 'c:implementation:0:0',
            \ 'f:function',
            \ 'g:enum',
            \ 't:type alias',
            \ 'v:global variable',
            \ 'M:macro',
            \ 'm:struct field',
            \ 'e:enum variant',
            \ 'P:method',
            \ '?:unknown',
            \ ],
            \ }

let g:tagbar_type_go = {
            \ 'kinds' : [
            \ 'p:packages:0:0',
            \ 'i:interfaces:0:0',
            \ 'c:constants:0:0',
            \ 's:structs',
            \ 'm:struct members:0:0',
            \ 't:types',
            \ 'f:functions',
            \ 'v:variables:0:0',
            \ '?:unknown',
            \ ],
            \ }

let g:tagbar_type_python = {
            \ 'kinds' : [
            \ 'i:modules:1:0',
            \ 'c:classes',
            \ 'f:functions',
            \ 'm:members',
            \ 'v:variables:0:0',
            \ '?:unknown',
            \ ],
            \ }

" Set vim to transparent before starting so no settings can change it
hi Normal guibg=NONE ctermbg=NONE
