"----------------------------------------------------------------------                 RMD map for compiling
"----------------------------------------------------------------------
    autocmd Filetype rmd map <F10> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

"----------------------------------------------------------------------
"                   General Re-mappings
"----------------------------------------------------------------------


" Remap Capital J/K to move up and down blocks
    nnoremap J }
    vmap J }
    nnoremap K {
    vmap K {

" Set U as Ctrl R which means Redo
    nnoremap U <C-R>

" Use B to move to beginning of line
    map B ^

" Use E to move to end of line in
    map E $

" Map ,, to % because i like cycling brackets a lot
    map ,, %

" Align blocks of text and keep them selected
    vmap < <gv
    vmap > >gv

" Lots of Time-Stamp Options here in normal/insert mode to paste timestamp and F4 To Date Stamp
    "nnoremap <F3> "=strftime("%H:%M:%S")<CR>p
    "inoremap <F3> <C-R>=strftime("%H:%M:%S")<CR>
    nnoremap <F4> "=strftime("%Y-%m-%d")<CR>p
    inoremap <F4> <C-R>=strftime("%Y-%m-%d")<CR>
    nnoremap <F5> a"<ESC>"=strftime("%Y-%m-%d %H:%M:%S")<CR>pa"<ESC>
    inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
    nnoremap <F6> "=strftime("%A %B %d %Y, at %I:%M %p %Z")<CR>P
    inoremap <F6> <C-R>=strftime("%A %B %d, at %I:%M %p %Z")<CR>

" List all buffers and jump to them using 'gb'
    nnoremap gb :ls<CR>:b<Space>

" List all recently opened files and open a new buffer
    nnoremap gs :browse oldfiles<CR>

" Set hh as jump out of 'vim' terminal mode
    tnoremap hh <C-\><C-n>

" Change directory to current directory
    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Shift Tab to cyle tabs
    nmap <S-Tab> :bn<CR>
    nmap <Tab> :bp<CR>

" Undo redo
    nnoremap U <C-R>
    " If you want to use C-Z, C-Y
    " nnoremap <C-Z> u
    " nnoremap <C-Y> <C-R>

    " Or use undo redo in insert mode
    inoremap <C-Z> <C-O>u
    inoremap <C-Y> <C-O><C-R>


"----------------------------------------------------------------------
"               Map Leader to '<space>'
"               Map Llocalleader to \\
"----------------------------------------------------------------------

    let mapleader=' '
    let maplocalleader = '\'

" Turn off search highlight bullshit to Comma + Leader/space
    nnoremap ,<leader> :nohlsearch<CR>

" Run Last command in tmux window
    nnoremap ,gcc :!tmux send-keys -t1 "\!! " ENTER <CR><CR>

" Mac open dictionary under word cursor
    nnoremap <silent> <leader>? :!open dict://<cword><cr><cr>

" Open URL or thing in default browser or whatever
    nnoremap <silent> <leader>@ :!open <cfile><cr><cr>

" Delete Buffer, but keep the window open
    nnoremap <leader>d :bp\|bd! #<CR>

" Jumplist stuff -> Backward and forward in vim jumps
" -> C-i && C-o aint that hard
    "nnoremap <leader>i <C-i>
    "nnoremap <leader>o <C-o>

" Fixing vim because I break it Later -> Move between blocks 'better'
    nnoremap <leader>j J

" Preview Marks!
    nnoremap  <leader>m :marks<CR>

" Copy & Paste into vim in normal mode
    noremap <leader>p  "+p
    noremap <leader>y  "+y
    noremap yy "+y"


" Quicksave and Quickquit in vim!
    nnoremap <leader>s :update<cr>
    nnoremap <leader>q :q!<CR>
    nnoremap <A-s> :w<CR>
    map <leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
" Resize Vim window
    nnoremap <Up> :resize +2<CR>
    nnoremap <Down> :resize -2<CR>
    nnoremap <Left> :vertical resize +2<CR>
    nnoremap <Right> :vertical resize -2<CR>


" Split window
    nnoremap <leader>vs :split<Return>
    nnoremap <leader>vv :vsplit<Return>

" Increment Decrement Numbers
    nnoremap <A-a> <C-a>
    nnoremap <A-x> <C-x>


" Show syntax color highlighting groups for word under cursor with Ctrl-Shift-P
    nmap <c-a> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
      if !exists("*synstack")
        return
      endif
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunction

" leader+r to search and replace in file
    nnoremap <leader>r :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

"----------------------------------------------------------------------
"               Terminal
"----------------------------------------------------------------------
" Terminal Mappings
    function! TerminalCreate()
        let time_now = strftime("%T")
        let terminal_name = "terminal_" . time_now
        execute "terminal"
        execute "set nonumber"
        execute "file " . termnal_name
        normal A
    endfunction

" Leader+z = create new terminal buffer BELOW
    nnoremap <leader>zb :new<CR>:resize 10<CR>:call TerminalCreate()<CR>

" Leader+zb = new terminal in a new window completely by itself
    nnoremap <leader>zz :call TerminalCreate()<CR>

" Leader+zv = new terminal in a new vertical split
    nnoremap <leader>zv :vsplit<CR>:call TerminalCreate()<CR>


" Markdown Remaps
function! PandocCreate()
  let curr_file = expand('%:t')                             " Name of current file
  let pdf_file = expand('%:r') . '.pdf'                     " Name of file with pdf extension
  execute '!pandoc --pdf-engine=xelatex ' . curr_file . ' -o ' . pdf_file
  if filereadable(pdf_file)
      execute '!open ' . pdf_file
  endif
endfunction

" Pandoc Remaps
    autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
    autocmd FileType markdown nnoremap <F7> :update<CR>:call PandocCreate()<CR>

" Make/Compile current Latex File
function! LatexCreate()
  let curr_file = expand('%:t')                             " Name of current file
  let pdf_file = expand('%:r') . '.pdf'                     " Name of file with pdf extension
  execute '!pdflatex  ./' . curr_file
  execute '!open ' . pdf_file
  execute '!open -a "iterm.app"'
endfunction

" LaTeX Remaps
    autocmd FileType tex nnoremap ,comp :update<CR>:call LatexCreate()<CR>
    autocmd FileType tex nnoremap ,top :-1read $HOME//nvim/snippets/blockLatex.txt<CR>


" Make/Compile current Groff MOM File
"function! GroffCreate()
  "let curr_file = expand('%:t')                             " Name of current file
  "let pdf_file = expand('%:r') . '.pdf'                     " Name of file with pdf extension
  "" Pipe the output and then open terminal and pdf
  "execute ':!pdfmom  -e ./' . curr_file . ' > ' . pdf_file
  "execute ':!open ' . pdf_file
  "execute ':!open -a "iterm.app"'
"endfunction

" GNUroff (Groff) completions
    "autocmd BufRead,BufNewFile *.ms,*.me,*.mom set filetype=groff
    "autocmd FileType groff nnoremap ,ee i.EQ<CR>.EN<ESC>O<tab>
    "autocmd FileType groff nnoremap ,cc i\" <ESC>a
    "autocmd FileType groff nnoremap ,block :read $HOME/.config/nvim/snippets/blockGroff.txt<CR>jA
    "autocmd FileType groff nnoremap ,top :-1read $HOME/.config/nvim/snippets/topGroff.txt<CR>2jA <C-R>=strftime("%A %B %d %Y, at %I:%M %p %Z")<CR><ESC>jA
    "autocmd FileType groff nnoremap ,mom :-1read $HOME/.config/nvim/snippets/momGroff.txt<CR>
    "autocmd FileType groff nnoremap ,groff :-1read $HOME/.config/nvim/snippets/groff.txt<CR>
    "autocmd FileType groff nnoremap ,comp :update<CR>:call GroffCreate()<CR>

" School's C++ top snippet
    nnoremap ,top :-1read $HOME/.config/nvim/snippets/top.txt<CR>2jA <C-R>=strftime("%A %B %d %Y, at %I:%M %p %Z")<CR><ESC>jA

" School's Function block snippet
    nnoremap ,block :read $HOME/.config/nvim/snippets/block.txt<CR>jA

" C++ int main()
    nnoremap ,c++ :read $HOME/.config/nvim/snippets/c++.txt<CR>jo<tab>

" Post snippet
    nnoremap ,post :-1read $HOME/.config/nvim/snippets/post.md<CR>

" YAML snippet
    nnoremap ,yaml :-1read $HOME/.config/nvim/snippets/yaml.md<CR>
    nnoremap ,yaml1 :-1read $HOME/.config/nvim/snippets/yamlcs.md<CR>

" MLK's Dream Speech
    nnoremap ,mlk :read $HOME/.config/nvim/snippets/mlk.txt<CR>

" Job snippet
    nnoremap ,job :read $HOME/.config/nvim/snippets/job.txt<CR>i


"-----------------------------------------------------------------
"                           Snippets
"-----------------------------------------------------------------

" Basic HTML Snippet!
    nnoremap ,html :-1read $HOME/.config/nvim/snippets/skeleton.html<CR>7jf>a

" Basic CSS Snippet!
    nnoremap ,css :-1read $HOME/.config/nvim/snippets/cssComment.css<CR>jA
    nnoremap ,csss :-1read $HOME/.config/nvim/snippets/skeleton.css<CR>


"-------------------------------------------------------------------
"*******************************************************************
"                       TRANSPARENCY
"*******************************************************************
"-------------------------------------------------------------------
" Set transparent color - let's it always in the end
" Set vim to transparent before starting so no settings can change it
"hi Normal guibg=NONE ctermbg=NONE
