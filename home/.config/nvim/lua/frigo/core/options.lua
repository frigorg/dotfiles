vim.cmd("let g:netrw_liststyle = 3")
-- vim.cmd("autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=300}") --FIX: not working. 

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.numberwidth = 3

-- Tabs and indentation
opt.tabstop = 2 -- Spaces for TAB
opt.shiftwidth = 2 -- Spaces for indentation
opt.expandtab = true -- TABs to be spaces
opt.autoindent = true -- Copy relative indentation to next new line

opt.wrap = true -- Prevent showing line beyond window width
    
-- Search settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- If mixed cases are included, it assumes case-sensitive search

opt.cursorline = true -- Exibits a horizontal line under the cursor

opt.termguicolors = true
opt.background = "dark"
-- opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default
  
-- Split window
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the botton

