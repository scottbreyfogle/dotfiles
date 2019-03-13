" YAPF
nnoremap <leader>y :call yapf#YAPF()<cr>
autocmd BufWritePre FileType python call yapf#YAPF()
