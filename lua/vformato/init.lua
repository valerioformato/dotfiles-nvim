vim.g.mapleader = " " -- Set leader key before Lazy

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Default indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Auto-reload files when changed externally
vim.opt.autoread = true
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold'}, {
  command = 'checktime',
})
 
require("vformato.lazy_init")
require("vformato.lsp")
