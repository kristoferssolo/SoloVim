return {
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		keys = {
			{ "<leader>oi", vim.cmd.InlayHintsToggle, desc = "Toggle InlayHints" },
		},
		opts = {
			commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
			autocmd = { enable = true }, -- Enable the inlay hints on `LspAttach` event
		},
	},
	{
		"felpafel/inlay-hint.nvim",
		event = "LspAttach",
		version = "1.0.*",
		opts = {
			virt_text_pos = "eol",
			highlight_group = "comment",
			hl_mode = "combine",
			display_callback = function(line_hints, options, bufnr)
				if options.virt_text_pos == "inline" then
					local lhint = {}
					for _, hint in pairs(line_hints) do
						local text = ""
						local label = hint.label
						if type(label) == "string" then
							text = label
						else
							for _, part in ipairs(label) do
								text = text .. part.value
							end
						end
						if hint.paddingLeft then
							text = " " .. text
						end
						if hint.paddingRight then
							text = text .. " "
						end
						lhint[#lhint + 1] = { text = text, col = hint.position.character }
					end
					return lhint
				elseif options.virt_text_pos == "eol" or options.virt_text_pos == "right_align" then
					local k1 = {}
					local k2 = {}
					table.sort(line_hints, function(a, b)
						return a.position.character < b.position.character
					end)
					for _, hint in pairs(line_hints) do
						local label = hint.label
						local kind = hint.kind
						local text = ""
						if type(label) == "string" then
							text = label
						else
							for _, part in ipairs(label) do
								text = text .. part.value
							end
						end
						if kind == 1 then
							k1[#k1 + 1] = text:gsub("^:%s*", "")
						else
							k2[#k2 + 1] = text:gsub(":$", "")
						end
					end
					local text = ""
					if #k2 > 0 then
						text = " <- (" .. table.concat(k2, ",") .. ")"
					end
					if #text > 0 then
						text = text .. " "
					end
					if #k1 > 0 then
						text = text .. " => " .. table.concat(k1, ",")
					end

					return text
				end
				return nil
			end,
		},
	},
}
