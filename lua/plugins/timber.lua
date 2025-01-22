-- Action						Keymap		Description
-- insert_log_below				glj			Insert a log statement below the cursor
-- insert_log_above				glk			Insert a log statement above the cursor
-- insert_plain_log_below		glo			Insert a plain log statement below the cursor
-- insert_plain_log_above		gl<S-o> 	Insert a plain log statement above the cursor
-- add_log_targets_to_batch 	gla			Add a log target to the batch
-- insert_batch_log				glb			Insert a batch log statement
return {
	"Goose97/timber.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		log_templates = {
			default = {
				python = [[logger.debug(f"{%log_target=}")]],
			},
		},
	},
	config = function(_, opts)
		require("timber").setup(opts)
	end,
}
