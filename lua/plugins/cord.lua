return {
	"vyfor/cord.nvim",
	opts = {
		display = {
			view = "asset",
		},
		advanced = {
			discord = {
				reconnect = {
					enabled = true,
				},
			},
		},
		extensions = {
			--- https://github.com/vyfor/cord.nvim/wiki/Examples#-hiding-presence-for-certain-projects
		},
	},
	config = function(_, opts)
		local async = require("cord.core.async")
		local process = require("cord.core.uv.process")
		local buttons = {
			{
				label = "View Repository",
				url = async.wrap(function(ctx)
					-- check visibility only once every 5 minutes
					local is_private = ctx.cache:get_or_compute(ctx.workspace_dir .. ":is_repo_private", 300, function()
						local result = process
							.spawn({
								cmd = "gh",
								args = { "repo", "view", "--json", "isPrivate", "--template", "{{.isPrivate}}" },
								cwd = ctx.workspace_dir,
							})
							:await()

						-- assume private if command fails
						if not result or result.code ~= 0 then
							-- we must return a non-nil value
							return false
						end
						return vim.trim(result.stdout)
					end)

					if is_private == "true" then
						return
					end -- hide button for private repos

					return ctx.repo_url
				end),
			},
		}
		local config = vim.tbl_deep_extend("force", {}, opts, {
			buttons = buttons,
		})
		require("cord").setup(config)
	end,
}
