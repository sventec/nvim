-- filetype.nvim config file

filetype = require("filetype")

filetype.setup({
	overrides = {
		extensions = {
			-- gitignore = "gitignore",
		},
		literal = {
			[".gitignore"] = "gitignore",
		},

		shebang = {
			dash = "sh",
		},
	},
})
