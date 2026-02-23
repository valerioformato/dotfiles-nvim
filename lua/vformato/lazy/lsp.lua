return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					['<Tab>'] = cmp.mapping.select_next_item(),
					['<S-Tab>'] = cmp.mapping.select_prev_item(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = 'nvim_lsp' },
				},
			})
		end
	},
	{
		"hrsh7th/cmp-nvim-lsp"
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require('mason-tool-installer').setup {

				-- a list of all tools you want to ensure are installed upon
				-- start
				ensure_installed = {
					{ 'bash-language-server', auto_update = true },
					{ 'checkmake', auto_update = true },
					{ 'clang-format', auto_update = true },
					{ 'clangd', auto_update = true },
					{ 'cmake-language-server', auto_update = true },
					{ 'codelldb', auto_update = true },
					{ 'docker-language-server', auto_update = true },
					{ 'dockerfile-language-server', auto_update = true },
					{ 'docker-compose-language-service', auto_update = true },
					{ 'luacheck', auto_update = true },
					{ 'lua-language-server', auto_update = true },
					{ 'markdown-oxide', auto_update = true },
					{ 'python-lsp-server', auto_update = true },
					{ 'rust-analyzer', auto_update = true },
					{ 'shfmt', auto_update = true },
					{ 'yaml-language-server', auto_update = true },
				}
			}
		end
	}
}
