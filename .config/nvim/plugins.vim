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
    Plug 'tpope/vim-repeat'

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
    Plug 'reedes/vim-colors-pencil'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'arthurxavierx/vim-unicoder'
    Plug 'psliwka/vim-smoothie'
    " NEXT LEVEL SHIT
    Plug 'mhinz/vim-grepper'
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    Plug 'honza/vim-snippets'
    Plug 'Shougo/neoinclude.vim'
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


    " FORMATING
    Plug 'dense-analysis/ale'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-ragtag'
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
Plug 'jsfaint/coc-neoinclude'

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax'
Plug 'gko/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'


" javascript & typescript
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'peitalin/vim-jsx-typescript'


" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}


" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'thoughtbot/vim-rspec'




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
"               Map Leader to '<space>'
"               Map Llocalleader to \\
"----------------------------------------------------------------------

    let mapleader=' '
    let maplocalleader = '\'



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
colorscheme night-owl  " shades_of_purple




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
    let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

"----------------------------------------------------------------------
"                   GOYO && PENCIL WRITING
"----------------------------------------------------------------------

" Goyo start Writing!
    nnoremap <leader><ENTER> :Goyo<CR>

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

" Remap keys for gotos
    "nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> gd :call CocAction('jumpDefinition', 'split')<CR>
    nnoremap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>
    nnoremap <silent> gn :call CocAction('jumpDefinition', 'tabe')<CR>

" COC for typescript
let g:coc_global_extensions = [ 'coc-tsserver' ]

" Ignore node_modules folder:
" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Tool tip documentation and diagnostics

nnoremap <silent> <leader>² :call CocAction('doHover')<CR>

" Automatic diagnostic when cursoring overa word
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()


" Diagnostic warning & error list in current file with coc-list
nnoremap <silent> <space>ld :<C-u>CocList diagnostics<cr>
" Diagnostic worspace symbol
nnoremap <silent> <space>ly :<C-u>CocList -I symbols<cr>
" Performing code action
nmap <leader>pe <Plug>(coc-codeaction)


"----------------------------------
"       Default config COC NVIM
"----------------------------------

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)



" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

" Remap <C-*> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-*> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-*>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-*> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-*> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-*>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
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
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
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
let NERDTreeShowHidden=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

nnoremap <F2> :NERDTreeFind<CR>
nnoremap <F3> :NERDTreeToggle<CR>


vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nmap <leader>w <plug>NERDCommenterToggle


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
nnoremap <A-t> :TagbarToggle<CR>

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


"Emmet
let g:user_emmet_leader_key='<C-Z>'
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 1
"ALE
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'python': ['pylint'],
\   'vue': ['eslint', 'vls'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace','prettier'],
\   'python': ['black']
\}
let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_options = '--semi --single-quote --trailing-comma all'


" Vim surround
" Allow to remap key vim surround from default
let g:surround_no_mappings=1


" vim-jsx-typescript
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" Hight light for large file
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
