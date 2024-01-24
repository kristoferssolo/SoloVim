return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ccc = require("ccc")
		local ColorInput = require("ccc.input")
		local convert = require("ccc.utils.convert")

		local RgbHslInput = setmetatable({
			name = "RGB/HSL",
			max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
			min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
			delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
			bar_name = { "R", "G", "B", "H", "S", "L" },
		}, { __index = ColorInput })

		function RgbHslInput.format(n, i)
			if i <= 3 then
				-- RGB
				n = n * 255
			elseif i >= 5 then
				-- S or L of HSL
				n = n * 100
			end
			return ("%6d"):format(n)
		end

		function RgbHslInput.from_rgb(RGB)
			local HSL = convert.rgb2hsl(RGB)
			local R, G, B = unpack(RGB)
			local H, S, L = unpack(HSL)
			return { R, G, B, H, S, L }
		end

		function RgbHslInput.to_rgb(value)
			return { value[1], value[2], value[3] }
		end

		function RgbHslInput:_set_rgb(RGB)
			self.value[1] = RGB[1]
			self.value[2] = RGB[2]
			self.value[3] = RGB[3]
		end

		function RgbHslInput:_set_hsl(HSL)
			self.value[4] = HSL[1]
			self.value[5] = HSL[2]
			self.value[6] = HSL[3]
		end

		function RgbHslInput:callback(index, new_value)
			self.value[index] = new_value
			local v = self.value
			if index <= 3 then
				local RGB = { v[1], v[2], v[3] }
				local HSL = convert.rgb2hsl(RGB)
				self:_set_hsl(HSL)
			else
				local HSL = { v[4], v[5], v[6] }
				local RGB = convert.hsl2rgb(HSL)
				self:_set_rgb(RGB)
			end
		end

		ccc.setup({
			pickers = {
				ccc.picker.custom_entries({
					bg = "#1a1b26",
					bg_dark = "#16161e",
					bg_float = "#16161e",
					bg_highlight = "#292e42",
					bg_popup = "#16161e",
					bg_search = "#3d59a1",
					bg_sidebar = "#16161e",
					bg_statusline = "#16161e",
					bg_visual = "#283457",
					black = "#15161e",
					blue = "#7aa2f7",
					blue0 = "#3d59a1",
					blue1 = "#2ac3de",
					blue2 = "#0db9d7",
					blue5 = "#89ddff",
					blue6 = "#b4f9f8",
					blue7 = "#394b70",
					border = "#15161e",
					border_highlight = "#27a1b9",
					comment = "#565f89",
					cyan = "#7dcfff",
					dark3 = "#545c7e",
					dark5 = "#737aa2",
					delta_add = "#2c5a66",
					delta_delete = "#713137",
					diff_add = "#20303b",
					diff_change = "#1f2231",
					diff_delete = "#37222c",
					diff_text = "#394b70",
					error = "#db4b4b",
					fg = "#c0caf5",
					fg_dark = "#a9b1d6",
					fg_float = "#c0caf5",
					fg_gutter = "#3b4261",
					fg_sidebar = "#a9b1d6",
					git_add = "#449dab",
					git_change = "#6183bb",
					git_delete = "#914c54",
					git_ignore = "#545c7e",
					gitSigns_add = "#266d6a",
					gitSigns_change = "#536c9e",
					gitSigns_delete = "#b2555b",
					green = "#9ece6a",
					green1 = "#73daca",
					green2 = "#41a6b5",
					hint = "#1abc9c",
					info = "#0db9d7",
					magenta = "#bb9af7",
					magenta2 = "#ff007c",
					none = "NONE",
					orange = "#ff9e64",
					purple = "#9d7cd8",
					red = "#f7768e",
					red1 = "#db4b4b",
					teal = "#1abc9c",
					terminal_black = "#414868",
					warning = "#e0af68",
					yellow = "#e0af68",
				}),
			},
			inputs = {
				RgbHslInput,
			},
		})
	end,
}
