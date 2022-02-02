-- bufferline config

local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup{
  options = {
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
  }
}

