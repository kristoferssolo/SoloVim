local function make_mapper(mode)
	return function(keys, func, desc, opts)
		vim.keymap.set(mode, keys, func, vim.tbl_extend("force", { desc = desc }, opts or {}))
	end
end

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	branch = "main",
	init = function()
		vim.g.no_plugin_maps = true
	end,
	opts = {
		select = {
			lookahead = true,
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<C-v>", -- blockwise
			},
		},
		move = {
			set_jumps = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter-textobjects").setup(opts)

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		local function textobject(query, query_group)
			return function()
				select.select_textobject(query, query_group or "textobjects")
			end
		end

		local function textobject_move(method, query, query_group)
			return function()
				move[method](query, query_group or "textobjects")
			end
		end

		local function textobject_swap(method, query)
			return function()
				swap[method](query)
			end
		end

		local select_map = make_mapper({ "x", "o" })
		local move_map = make_mapper({ "n", "x", "o" })
		local swap_map = make_mapper("n")
		local repeat_map = make_mapper({ "n", "x", "o" })

		select_map("aa", textobject("@parameter.outer"), "Select outer part of a parameter")
		select_map("ia", textobject("@parameter.inner"), "Select inner part of a parameter")

		select_map("af", textobject("@function.outer"), "Select outer part of a function")
		select_map("if", textobject("@function.inner"), "Select inner part of a function")

		select_map("ac", textobject("@class.outer"), "Select outer part of a class region")
		select_map("ic", textobject("@class.inner"), "Select inner part of a class region")

		select_map("ai", textobject("@conditional.outer"), "Select outer part of a conditional")
		select_map("ii", textobject("@conditional.inner"), "Select inner part of a conditional")

		select_map("al", textobject("@loop.outer"), "Select outer part of a loop")
		select_map("il", textobject("@loop.inner"), "Select inner part of a loop")

		select_map("at", textobject("@comment.outer"), "Select outer part of a comment")
		select_map("as", textobject("@scope", "locals"), "Select language scope")

		move_map("]m", textobject_move("goto_next_start", "@function.outer"), "Next function start")
		move_map("]M", textobject_move("goto_next_end", "@function.outer"), "Next function end")
		move_map("[m", textobject_move("goto_previous_start", "@function.outer"), "Previous function start")
		move_map("[M", textobject_move("goto_previous_end", "@function.outer"), "Previous function end")

		move_map("]]", textobject_move("goto_next_start", "@class.outer"), "Next class start")
		move_map("][", textobject_move("goto_next_end", "@class.outer"), "Next class end")
		move_map("[[", textobject_move("goto_previous_start", "@class.outer"), "Previous class start")
		move_map("[]", textobject_move("goto_previous_end", "@class.outer"), "Previous class end")

		move_map("]i", textobject_move("goto_next", "@conditional.inner"), "Next conditional")
		move_map("[i", textobject_move("goto_previous", "@conditional.inner"), "Previous conditional")

		swap_map("]a", textobject_swap("swap_next", "@parameter.inner"), "Swap with next parameter")
		swap_map("[a", textobject_swap("swap_previous", "@parameter.outer"), "Swap with previous parameter")

		repeat_map(";", ts_repeat_move.repeat_last_move_next, "Repeat last move forward")
		repeat_map(",", ts_repeat_move.repeat_last_move_previous, "Repeat last move backward")

		repeat_map("f", ts_repeat_move.builtin_f_expr, "Find character forward", { expr = true })
		repeat_map("F", ts_repeat_move.builtin_F_expr, "Find character backward", { expr = true })
		repeat_map("t", ts_repeat_move.builtin_t_expr, "Till character forward", { expr = true })
		repeat_map("T", ts_repeat_move.builtin_T_expr, "Till character backward", { expr = true })
	end,
}
