-- Purpose: Basic settings
local o = vim.o
local home = vim.fn.expand("$HOME")

vim.cmd("filetype plugin indent on") -- enable filetype detection
vim.cmd("syntax on") -- enable syntax highlighting

-- Window options
vim.wo.nu = true -- Display numbers
vim.wo.signcolumn = "number" -- Merge signcolumn and numbers

-- Editor options
o.hidden = true -- hide some buffers
o.showmatch = true -- Visually show matching bracket
o.wrap = true -- Wrap text
o.mouse = "a" -- Allow mouse
o.inccommand = "split" -- icremental search to open preview window
o.splitbelow = true -- Split window to the bottom
o.splitright = true -- Split window to right
o.smartcase = true -- Use smart case
o.ignorecase = true -- Ignore case
o.wildignorecase = true -- Ignore case in wildignore
o.wildignore = [[*.swp,*.bak,*.cache,*.min.*,**/dist/**,**/.git/**,*-lock.json,]] -- Wildignore paths
o.errorformat = o.errorformat .. ",%f," -- Set fd errorformat
o.path = ".,,**" -- Set standard path
o.clipboard = "unnamed" .. o.clipboard -- os clipboard

-- Backup, undo, swap options
o.undofile = true -- Set this option to have full undo power
o.backup = true -- Set this option to enable backup
o.writebackup = true -- Set this option to write back up
o.backupdir = home .. "/.config/nvim/tmp/dir_backup/" -- Back up dir
o.directory = home .. "/.config/nvim/tmp/dir_swap/," .. o.directory -- Swap file dir
o.undodir = home .. "/.config/nvim/tmp/dir_undo/" -- Undo dir

-- Statusline
o.laststatus = 2 -- Dont display statusline
o.statusline = [[ ❮ %<%f %h%m%r%=%-14.(%l,%c%V%) %P ❯ ]] -- custom statusline format
o.showmode = true -- Don't display mode in cmd

-- Insert mode
o.iminsert = 1

-- Use rg for grep
if vim.fn.executable("rg") then
  vim.g.grepprg = "rg"
  o.grepprg = vim.g.grepprg .. " --vimgrep"
  o.grepformat = "%f:%l:%c:%m"
end
