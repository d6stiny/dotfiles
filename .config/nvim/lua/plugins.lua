return {
	{
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme duskfox")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules/.*",
						"secret.d/.*",
						"%.pem",
					},
					prompt_prefix = "$ ",
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")

			local options = { noremap = true, silent = true }

			-- Builtin
			vim.keymap.set("n", "<leader>fg", '<CMD>lua require("telescope.builtin").git_files{}<CR>', options)
			vim.keymap.set(
				"n",
				"<leader>ff",
				'<CMD>lua require("telescope.builtin").find_files{ hidden = true }<CR>',
				options
			)
			vim.keymap.set("n", "<leader>fl", '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
			vim.keymap.set("n", "<leader>fb", '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
			vim.keymap.set("n", "<leader>fh", '<CMD>lua require("telescope.builtin").help_tags()<CR>', options)
			vim.keymap.set("n", "<leader>fd", '<CMD>lua require("telescope.builtin").diagnostics()<CR>', options)
			vim.keymap.set("n", "<leader>fr", '<CMD>lua require("telescope.builtin").registers()<CR>', options)

			-- Language Servers
			vim.keymap.set("n", "<leader>lsd", '<CMD>lua require("telescope.builtin").lsp_definitions{}<CR>', options)
			vim.keymap.set(
				"n",
				"<leader>lsi",
				'<CMD>lua require("telescope.builtin").lsp_implementations{}<CR>',
				options
			)
			vim.keymap.set("n", "<leader>lsl", '<CMD>lua require("telescope.builtin").lsp_code_actions{}<CR>', options)
			vim.keymap.set(
				"n",
				"<leader>lst",
				'<CMD>lua require("telescope.builtin").lsp_type_definitions{}<CR>',
				options
			)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"bash",
					"dockerfile",
					"go",
					"javascript",
					"json",
					"nix",
					"swift",
					"terraform",
					"tsx",
					"typescript",
				},
			})
		end,
	},
	{ "github/copilot.vim" },
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
				},
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"gopls",
					"jsonls",
					"tsserver",
					"mdx_analyzer",
					"volar",
					"yamlls",
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["yamlls"] = function()
					require("lspconfig").yamlls.setup({
						capabilities = capabilities,
						settings = {
							yaml = {
								schemas = {
									["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
								},
							},
						},
					})
				end,

				["jsonls"] = function()
					require("lspconfig").jsonls.setup({
						capabilities = capabilities,
						settings = {
							json = {
								schemas = {
									{
										fileMatch = { "package.json" },
										url = "https://json.schemastore.org/package.json",
									},
									{
										fileMatch = { "tsconfig*.json" },
										url = "https://json.schemastore.org/tsconfig.json",
									},
									{
										fileMatch = { ".prettierrc.json", ".prettierrc" },
										url = "https://json.schemastore.org/prettierrc.json",
									},
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "copilot" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(), -- Complete with tab
					["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Select previous item
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion with enter
					["<C-e>"] = cmp.mapping.close(), -- Close completion with Ctrl-e
					["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion menu with Ctrl-Space
				}),
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							buffer = "[Buffer]",
							path = "[Path]",
							copilot = "[Copilot]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				current_line_blame_formatter = " <author>, <author_time> · <summary> ",
			})
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
	},
	{
		"IogaMaster/neocord",
		event = "BufRead",
		config = function()
			require("neocord").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "junegunn/fzf", build = "./install --bin" },
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({})
		end,
	},
}
