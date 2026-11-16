local work_path = vim.fn.expand("~/repos/equilia")
local work_root = vim.uv.fs_realpath(work_path) or work_path

return {
	before_init = function(params, config)
		if not config.root_dir then
			return
		end

		local root = vim.uv.fs_realpath(config.root_dir) or config.root_dir
		if root ~= work_root and not vim.startswith(root, work_root .. "/") then
			return
		end

		params.initializationOptions =
			vim.tbl_extend("force", params.initializationOptions or {}, { typeCheckingMode = "off" })
	end,
}
