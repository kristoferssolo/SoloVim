if not pcall(require, "git-worktree") then
	return
end

local worktree = require("git-worktree")
worktree.on_tree_change(function(op, metadata)
	if op == worktree.Operations.Switch then
		print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
	end
end)
