setlocal foldmethod=syntax
setlocal foldnestmax=1
setlocal noexpandtab " Tabs rather than spaces

" Highlight spaces instead of tabs
match BadTabs //
match BadSpaces /^\t*\zs \+/
