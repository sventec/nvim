-- nvim-cmp config

-- nvim-cmp dictionary completions setup
-- local dict = require("cmp_dictionary")

-- dict.setup({
-- 	dic = {
-- 		["*"] = { "/usr/share/dict/words" },
-- 		-- ["markdown"] = "/usr/share/dict/words",
-- 		-- ["txt"] = "/usr/share/dict/words",
-- 	},
-- 	-- The following are default values
-- 	exact = 2,
-- 	first_case_insensitive = false,
-- })

local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local status_ok_lsnip, luasnip = pcall(require, "luasnip")
if not status_ok_lsnip then
  return
end

local status_ok_comparator, comparator = pcall(require, "cmp-under-comparator")
if not status_ok_comparator then
  return
end

-- credit LunarVim/Neovim-from-scratch for some excellent defaults

-- load luasnip vscode-like plugins (such as friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

-- load luasnip snipmate-like snippets (from snippets subdir)
require("luasnip.loaders.from_snipmate").load()

-- extend the _.snippets file for global filetypes
luasnip.filetype_extend("all", { "_" })

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- this disables the default mapping
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      --   vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lua = "[Lua]",
        neorg = "[Neorg]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "neorg" },
    { name = "buffer" },
    { name = "path" },
    -- {
    -- 	name = "dictionary",
    -- 	keyword_length = 3,
    -- },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      comparator.under, -- sort items beginning with _ at bottom (eg __init__)
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- disable cmp in current buffer
vim.api.nvim_set_keymap(
  "n",
  "<leader>c",
  "<cmd>lua require('cmp').setup.buffer { enabled = false }<CR>",
  { silent = true }
)

-- nvim-cmp-cmdline setup
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
