-- core settings, to be loaded (mostly) first

-- to globally reference E.G. util.packer_lazy_load()
_G.util = {}

local autocmd = vim.api.nvim_create_autocmd

-- Disable statusline in dashboard (credit NvChad)
autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt.laststatus = 0
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- load plugin after entering vim ui (credit NvChad)
util.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

util.merge_plugins = function(default_plugins)
  -- thanks NvChad!

  local final_table = {}

  for key, _ in pairs(default_plugins) do
    default_plugins[key][1] = key

    final_table[#final_table + 1] = default_plugins[key]
  end

  return final_table
end
