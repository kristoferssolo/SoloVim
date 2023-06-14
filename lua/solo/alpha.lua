local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

local function header()
	return {
		[[              ___                                       ]],
		[[             /\_ \                    __                ]],
		[[  ____    ___\//\ \     ___   __  __ /\_\    ___ ___    ]],
		[[ /',__\  / __`\\ \ \   / __`\/\ \/\ \\/\ \ /' __` __`\  ]],
		[[/\__, `\/\ \L\ \\_\ \_/\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[\/\____/\ \____//\____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/___/  \/___/ \/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}
end

local function footer()
	return "kristofers.xyz"
end

dashboard.section.header.val = header()
dashboard.section.buttons.val = {
	dashboard.button("f", " " .. " Find file", "<cmd>lua require('telescope.builtin').find_files()<cr>"),
	dashboard.button("e", " " .. " New file", "<cmd>ene <BAR> startinsert<cr>"),
	dashboard.button("\\", " " .. " Persistence", "<cmd>lua require('persistence').load()<cr>"),
	dashboard.button("r", " " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("t", " " .. " Find text", "<cmd>Telescope live_grep<cr>"),
	dashboard.button(
		"p",
		" " .. " Find project",
		"<cmd>lua require('telescope').extensions.projects.projects()<cr>"
	),
	dashboard.button("g", " " .. " Git", "<cmd>lua _LAZYGIT_TOGGLE()<cr>"),
	dashboard.button("c", " " .. " Config", "<cmd>e ~/.config/nvim/init.lua <cr>"),
	dashboard.button("q", " " .. " Quit", "<cmd>qa<cr>"),
}
dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
