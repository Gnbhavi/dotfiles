return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp", -- The autocomplete engine
			"hrsh7th/cmp-nvim-lsp", -- Connects autocomplete to LSP
			"L3MON4D3/LuaSnip", -- Snippet engine (required by cmp)
		},
		config = function()
			-- 1. Setup Autocompletion Menu first
			local cmp = require("cmp")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger autocomplete
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Press Enter to confirm selection
					["<Tab>"] = cmp.mapping.select_next_item(), -- Tab through the list
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Get suggestions from the language server
					{ name = "luasnip" }, -- Get snippet suggestions
				}),
			})

			-- 2. Ensure lspconfig is loaded so it registers default configs for Neovim 0.11+
			require("lspconfig")

			-- 3. Setup Mason & Automatically connect servers
			require("mason").setup()
			require("mason-lspconfig").setup({
				-- Tell Mason to automatically download the servers for your languages
				ensure_installed = { "pyright", "rust_analyzer", "bashls", "lua_ls", "texlab" },

				-- This handler automatically loops through every installed server
				handlers = {
                  function(server_name)
                    local opts = { capabilities = capabilities }
                    
                    -- Tell the Lua server to stop complaining about the 'vim' word
                    if server_name == "lua_ls" then
                      opts.settings = {
                        Lua = {
                          diagnostics = { globals = { "vim" } }
                        }
                      }
                    end

                    -- Use the Neovim 0.11+ native API
                    if vim.lsp.config then
                      vim.lsp.config(server_name, opts)
                      vim.lsp.enable(server_name)
                    else
                      -- Fallback just in case
                      require("lspconfig")[server_name].setup(opts)
                    end
                  end,
                },
			})

			-- 4. LSP Keymaps (These ONLY activate when you open a code file!)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					-- Go to definition (using Telescope!)
					map("gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
					-- Press Shift+K to see documentation for the function under your cursor
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					-- Space+r+n to rename a variable everywhere in the file
					map("<leader>rn", vim.lsp.buf.rename, "Rename Variable")
				end,
			})
		end,
	},
}
