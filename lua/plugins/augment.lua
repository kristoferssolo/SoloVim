--- Function to find all Git repositories under a specified path
--- @param path_from_home string: Path from home directory (e.g., "repos")
--- @return table: List of absolute paths to Git repositories
local function find_git_repos(path_from_home)
	local home = vim.fn.expand("~")
	local search_dir = vim.fs.normalize(home .. "/" .. path_from_home)

	if vim.fn.isdirectory(search_dir) ~= 1 then
		vim.notify("Directory" .. search_dir .. " does not exist", vim.log.levels.ERROR)
		return {}
	end

	local git_dirs = vim.fs.find(".git", {
		type = "directory",
		path = search_dir,
		limit = math.huge,
	})

	local repo_paths = {}
	for _, git_dir in ipairs(git_dirs) do
		local repo_path = vim.fn.fnamemodify(git_dir, ":h")
		table.insert(repo_paths, repo_path)
	end
	return repo_paths
end

--- Helper function to concatenate tables
--- @param ... Any number of tables to concatenate
--- @return table: A new table with all elements from the input tables
local function concat_tables(...)
	local result = {}
	for _, tbl in ipairs({ ... }) do
		for _, v in ipairs(tbl) do
			table.insert(result, v)
		end
	end
	return result
end

--- Function to find Git repositories from multiple paths
--- @param paths_or_path string|table Either a single path string or a table of path strings
--- @param ... Any number of paths relative to home directory
--- @return table: List of absolute paths to Git repositories
local function find_git_repos_from_paths(paths_or_path, ...)
	local paths = {}

	-- Check if the first argument is a table
	if type(paths_or_path) == "table" then
		paths = paths_or_path
	else
		-- First argument is a string (or other type), use it along with any additional arguments
		paths = { paths_or_path, ... }
	end

	local all_repos = {}

	for _, path in ipairs(paths) do
		-- Skip nil values or non-string values
		if path and type(path) == "string" then
			local repos = find_git_repos(path)
			all_repos = concat_tables(all_repos, repos)
		end
	end

	return all_repos
end

return {
	"augmentcode/augment.vim",
	cmd = "Augment",
	init = function()
		vim.g.augment_workspace_folders = find_git_repos_from_paths({ "repos", "Nextcloud/repos" })
	end,
}
