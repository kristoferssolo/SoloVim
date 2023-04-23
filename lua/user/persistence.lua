local status_ok, persistence = pcall(require, "persistence")
if not status_ok then
	return
end

persistence.setup({
	dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
	options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
	pre_save = nil, -- a function to call before saving the session
})
