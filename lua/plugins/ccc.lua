return {
	"uga-rosa/ccc.nvim",
	opts = function()
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

		return {
			pickers = {
				ccc.picker.custom_entries({
					base = "#191724",
					surface = "#1f1d2e",
					overlay = "#26233a",
					muted = "#6e6a86",
					subtle = "#908caa",
					text = "#e0def4",
					love = "#eb6f92",
					gold = "#f6c177",
					rose = "#ebbcba",
					pine = "#31748f",
					foam = "#9ccfd8",
					iris = "#c4a7e7",
					highlight_low = "#21202e",
					highlight_med = "#403d52",
					highlight_high = "#524f67",
				}),
			},
			inputs = {
				RgbHslInput,
			},
		}
	end,
}
