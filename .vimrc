let mapleader = " "                  " Set the leader key to space

set clipboard=unnamedplus            " Use the system clipboard for all operations
set expandtab                        " Use spaces instead of tabs
set scrolloff=3                      " Keep 3 lines visible above and below the cursor
set shiftwidth=4                     " Number of spaces to use for each step of (auto)indent
set shortmess+=c                     " Avoid showing extra messages when using completion
set tabstop=4                        " Number of spaces that a <Tab> counts for
set termguicolors                    " Enable true color support
set updatetime=300                   " Set the time in milliseconds for CursorHold event and swap file updates
set mouse=a                          " Enable mouse support in all modes
set cursorline                       " Highlight the screen line of the cursor
set breakindent                      " Enable break indent
set undofile                         " Save undo history to a file
set ignorecase                       " Case-insensitive searching unless \C or capital in search
set smartcase                        " Override ignorecase if search pattern contains uppercase letters
set signcolumn=yes                   " Always show the sign column (e.g., for linting or version control)
set updatetime=250                   " Set the time in milliseconds for CursorHold event and swap file updates (duplicate, corrected to 250)
set timeoutlen=300                   " Set the time in milliseconds to wait for a mapped sequence to complete
set completeopt=menuone,noselect     " Configure completion options
set foldmethod=expr                  " Use expression for folding
set number                           " Show line numbers
set relativenumber                   " Show relative line numbers
set nowrap                           " Do not wrap long lines
set list                             " Show invisible characters (e.g., spaces, tabs, end of lines)
set listchars+=eol:↴                 " Customize characters to show for invisible characters
