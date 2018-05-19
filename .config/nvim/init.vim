if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('fishbullet/deoplete-ruby')

  call dein#add('chriskempson/base16-vim')

  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('sheerun/vim-polyglot')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('slashmili/alchemist.vim')
  call dein#add('mattn/emmet-vim')

  call dein#add('janko-m/vim-test')
  call dein#add('jpalardy/vim-slime')
  call dein#add('kassio/neoterm')

  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('mhinz/vim-sayonara')

  call dein#add('Shougo/denite.nvim')

  call dein#add('christoomey/vim-tmux-navigator')

  call dein#add('tomtom/tcomment_vim')
  call dein#add('AndrewRadev/splitjoin.vim')

  "" Ruby specific
  call dein#add('kana/vim-textobj-user')
  call dein#add('tek/vim-textobj-ruby')

  call dein#add('w0rp/ale')

  call dein#end()
  call dein#save_state()
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

filetype plugin indent on
set hidden
syntax enable
set mouse=a
set clipboard=unnamed
set updatetime=100

set tabstop=2 expandtab shiftwidth=2 smarttab
set inccommand=split

""" Key bindings
map <space> <leader>
nnoremap + :bnext<CR>
nnoremap _ :bprevious<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>

nnoremap ,q :Sayonara!<CR>
""" End Key bindings

""" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
""" End Deoplete

""" Vim-Slime
let g:slime_target = "tmux"
nnoremap <silent> <f10> ggVG :SlimeSend<cr>
nnoremap <silent> <f9> :SlimeSend<cr>
vnoremap <silent> <f9> :SlimeSend<cr>
""" End Vim-Slime

""" Neoterm
" nnoremap <silent> <f10> :TREPLSendFile<cr>
" nnoremap <silent> <f9> :TREPLSend<cr>
" vnoremap <silent> <f9> :TREPLSend<cr>


""" Vim-Test
let test#strategy = "neoterm"
nnoremap <leader>tt :TestFile<cr>
nnoremap <leader>tT :TestSuite<cr>
""" End Vim-Test

""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"""

""" Denite
augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call denite#custom#option('default',
        \'winheight', winheight(0) / 2)
augroup end

call denite#custom#var('file_rec', 'command',
			\ ['rg', '--files'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <leader>ff :Denite file_rec<cr>
nnoremap <leader>fl :Denite line<cr>
nnoremap <leader>fg :Denite grep<cr>

nnoremap <leader>wf :DeniteCursorWord file_rec<cr>
nnoremap <leader>wl :DeniteCursorWord line<cr>
nnoremap <leader>wg :DeniteCursorWord grep<cr>

nnoremap <leader>pf :DeniteProjectDir file_rec<cr>
nnoremap <leader>pl :DeniteProjectDir line<cr>
nnoremap <leader>pg :DeniteProjectDir grep<cr>

""" ALE
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'js': ['prettier', 'eslint'],
\   'jsx': ['prettier', 'eslint'],
\}
