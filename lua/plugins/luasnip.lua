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

-- helper function to return current date
local date = function()
  return { os.date("%Y-%m-%d") }
end

-- additional snippets
ls.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      namr = "Date",
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      func(date, {}),
    }),
  },
})
