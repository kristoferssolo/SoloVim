vim.filetype.add({
	extension = {
		jinja = "jinja",
		jinja2 = "jinja",
		j2 = "jinja",
		askama = "askama",
	},
	pattern = {
		-- Askama's default template directory; leave ordinary HTML files alone.
		[".*/templates/.*%.html"] = "askama",
		[".*%.askama%.html"] = "askama",
	},
})
