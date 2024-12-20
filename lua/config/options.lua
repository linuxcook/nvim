-- Important leader key information
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt

opt.autowrite = true
opt.clipboard = 'unnamedplus'
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.foldlevel = 99
opt.mouse = 'a'
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false
opt.scrolloff = 4
opt.shiftround = true
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- We have a status line
opt.sidescrolloff = 8
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5
opt.wrap = true -- Line wrapping
opt.smoothscroll = true
