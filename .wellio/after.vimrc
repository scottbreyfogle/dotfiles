" YAPF
nnoremap <leader>y :call yapf#YAPF()<cr>
autocmd BufWritePre FileType python call yapf#YAPF()
" Flake8
nnoremap <leader>f :call Flake8()<cr>
