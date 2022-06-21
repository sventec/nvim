-- luasnip config & some common snippets
local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node
local partial = require("luasnip.extras").partial

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      partial(os.date, "%Y-%m-%d"),
    }),
  },
})

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "datehr",
      namr = "Date (HR)",
      dscr = "Human Readable date in the form of Month DD, YYYY",
    }, {
      partial(os.date, "%b %d, %Y"),
    }),
  },
})
