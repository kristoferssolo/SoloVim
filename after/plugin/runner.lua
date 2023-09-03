if not pcall(require, "runner") then
	return
end

local runner = require("runner")
local choice = require("runner.handlers.helpers").choice
local helpers = require("runner.handlers.helpers")

runner.setup({
	position = "right", -- position of the terminal window when using the shell_handler
	-- can be: top, left, right, bottom
	-- will be overwritten when using the telescope mapping to open horizontally or vertically
	width = 50, -- width of window when position is left or right
	height = 10, -- height of window when position is top or bottom
})

runner.set_handler(
	"cpp",
	choice({
		Cmake = function()
			-- vim.cmd.CMakeBuild()
			vim.cmd.CMakeRun()
		end,
		Makefile = helpers.shell_handler("make"),
		["g++"] = helpers.shell_handler(
			"g++ " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. " && " .. vim.fn.expand("%:r")
		),
		Custom = helpers.shell_handler("", true),
	})
)

runner.set_handler(
	"c",
	choice({
		Cmake = vim.cmd.CMakeRun,
		Makefile = helpers.shell_handler("make"),
		["gcc"] = helpers.shell_handler(
			"gcc " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r") .. " && " .. vim.fn.expand("%:r")
		),
		Custom = helpers.shell_handler("", true),
	})
)

-- runner.set_handler(
-- 	"python",
-- 	choice({
-- 		Python = helpers.shell_handler("python " .. vim.fn.expand("%:t")),
-- 		Custom = helpers.shell_handler("", true),
-- 	})
-- )
