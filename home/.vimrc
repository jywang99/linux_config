" line numbers
set number
set relativenumber

" search
set ignorecase
set smartcase
set hlsearch

" whitespace
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wrap
set autoindent          " auto indenting
filetype indent on      " activates indenting for files

" UI
set cursorline
colorscheme koehler
syntax on               " syntax highlighting

" copy-paste
set clipboard=unnamed

" others
set nobackup            " get rid of anoying ~file

" Autocmds

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif

" color
hi Normal guibg=NONE ctermbg=NONE

