-- indent-blankline settings

local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent_blankline.setup({
	indentLine_enabled = 1,
	char = "▏",
	filetype_exclude = {
		"help",
		"terminal",
		"dashboard",
		"packer",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"nvchad_cheatsheet",
		"lsp-installer",
		"startify",
		"neogitstatus",
		"NvimTree",
		"Trouble",
		"",
		"txt",
	},
	buftype_exclude = { "terminal", "nofile" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = false, -- seems to be buggy atm
	-- use_treesitter = true,
})

-- vim.g.indent_blankline_context_patterns = {
-- 	"class",
-- 	"return",
-- 	"function",
-- 	"method",
-- 	"^if",
-- 	"^while",
-- 	"jsx_element",
-- 	"^for",
-- 	"^object",
-- 	"^table",
-- 	"block",
-- 	"arguments",
-- 	"if_statement",
-- 	"else_clause",
-- 	"jsx_element",
-- 	"jsx_self_closing_element",
-- 	"try_statement",
-- 	"catch_clause",
-- 	"import_statement",
-- 	"operation_type",
-- }
