return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter", -- Loads when you start typing
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false }, -- Using cmp instead
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
