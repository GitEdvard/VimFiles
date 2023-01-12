Plug 'preservim/nerdtree'

let NERDTreeShowHidden=1

function! ToggleNERDTree()
  NERDTreeToggle
  " Set NERDTree instances to be mirrored
  silent NERDTreeMirror
endfunction

au FileType nerdtree vert resize 50
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeMinimalMenu=1
let g:NERDTreeQuitOnOpen = 1

nmap <leader>n :NERDTreeFind<CR>
