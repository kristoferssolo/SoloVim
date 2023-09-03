local M = {}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

M.nmap = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

M.imap = function(keys, func, desc)
	vim.keymap.set("i", keys, func, { desc = desc })
end

M.vmap = function(keys, func, desc)
	vim.keymap.set("v", keys, func, { desc = desc })
end

M.xmap = function(keys, func, desc)
	vim.keymap.set("x", keys, func, { desc = desc })
end

M.tmap = function(keys, func, desc)
	vim.keymap.set("t", keys, func, { desc = desc })
end

M.cmap = function(keys, func, desc)
	vim.keymap.set("c", keys, func, { desc = desc })
end
return M
