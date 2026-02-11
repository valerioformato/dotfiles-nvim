-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/'

-- Configure lua_ls
vim.lsp.config['lua_ls'] = {
  cmd = { mason_bin .. 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  capabilities = capabilities,
}

-- Configure clangd for C/C++
-- Function to find compile_commands.json in multiple build directories
local function get_clangd_cmd()
  local cmd = { mason_bin .. 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' }
  
  -- List your build directories in order of preference
  local build_dirs = { 'build', 'build/debug', 'build/release', 'cmake-build-debug', 'cmake-build-release', 'out/build' }
  
  for _, dir in ipairs(build_dirs) do
    local compile_commands = vim.fn.getcwd() .. '/' .. dir .. '/compile_commands.json'
    if vim.fn.filereadable(compile_commands) == 1 then
      table.insert(cmd, '--compile-commands-dir=' .. dir)
      break
    end
  end
  
  return cmd
end

vim.lsp.config['clangd'] = {
  cmd = get_clangd_cmd(),
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
  capabilities = capabilities,
}

-- Configure cmake-language-server
vim.lsp.config['cmake'] = {
  cmd = { mason_bin .. 'cmake-language-server' },
  filetypes = { 'cmake' },
  root_markers = { 'CMakeLists.txt', '.git' },
  capabilities = capabilities,
}

-- Configure bash-language-server
vim.lsp.config['bashls'] = {
  cmd = { mason_bin .. 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  capabilities = capabilities,
}

vim.lsp.enable({ 'lua_ls', 'clangd', 'cmake', 'bashls' })
