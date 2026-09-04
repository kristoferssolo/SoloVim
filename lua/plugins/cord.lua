local function get_is_private(ctx)
	if not (ctx.cache and ctx.workspace_dir) then
		return true
	end
	local process = require("cord.core.uv.process")
	-- check visibility only once every 5 minutes
	return ctx.cache:get_or_compute(ctx.workspace_dir .. ":is_repo_private", 300, function()
		local ok, result = pcall(function()
			return process
				.spawn({
					cmd = "gh",
					args = { "repo", "view", "--json", "isPrivate", "--template", "{{.isPrivate}}" },
					cwd = ctx.workspace_dir,
				})
				:await()
		end)
		-- assume private when `gh` can't tell us
		if not ok or result.code ~= 0 then
			return true
		end
		return vim.trim(result.stdout) == "true"
	end)
end

local function get_branch(ctx)
	if not (ctx.cache and ctx.workspace_dir) then
		return nil
	end
	local process = require("cord.core.uv.process")
	-- branches rarely change; re-check every minute
	return ctx.cache:get_or_compute(ctx.workspace_dir .. ":git_branch", 60, function()
		local ok, result = pcall(function()
			return process
				.spawn({ cmd = "git", args = { "rev-parse", "--abbrev-ref", "HEAD" }, cwd = ctx.workspace_dir })
				:await()
		end)
		if not ok or result.code ~= 0 then
			return nil
		end
		return vim.trim(result.stdout)
	end)
end

return {
	"vyfor/cord.nvim",
	opts = {
		display = {
			view = "asset",
			theme = "void", -- 'default', 'atom', 'catppuccin', 'minecraft', 'void', 'classic'
			flavor = "accent", -- 'dark', 'light', 'accent'
		},
		advanced = {
			discord = {
				reconnect = {
					enabled = true,
				},
			},
		},
		idle = {
			show_status = false,
		},
		extensions = {
			--- https://github.com/vyfor/cord.nvim/wiki/Examples#-hiding-presence-for-certain-projects
			visibility = {
				rules = {
					blacklist = {
						"solo-pi",
						"solo-protocol",
					},
				},
			},
		},
	},
	config = function(_, opts)
		local async = require("cord.core.async")

		opts.hooks = {
			post_activity = async.wrap(function(ctx, activity)
				if not ctx.repo_url then
					return
				end
				-- only public repos get clickable links
				if get_is_private(ctx) then
					return
				end
				activity.assets.large_url = ctx.repo_url

				-- link to the exact file at the cursor
				local branch = get_branch(ctx)
				local file = vim.fs.relpath(ctx.workspace_dir, vim.api.nvim_buf_get_name(0))
				if not (branch and file) then
					return
				end
				activity.details_url = require("snacks.gitbrowse").get_url(ctx.repo_url, {
					branch = branch,
					file = file,
					line_start = ctx.cursor_line,
					line_end = ctx.cursor_line,
				}, { what = "file" })
			end),
		}

		opts.buttons = {
			{
				label = "View Repository",
				url = async.wrap(function(ctx)
					if get_is_private(ctx) then
						return
					end
					return ctx.repo_url
				end),
			},
		}

		require("cord").setup(opts)
	end,
}
