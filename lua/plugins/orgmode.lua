local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

orgmode.setup_ts_grammar()

orgmode.setup({
  -- All destinations for refiling must be explicitly listed in org_agenda_files
  org_agenda_files = {
    "~/cloud/org/*",
    -- "~/cloud/org/projects.org",
    -- "~/cloud/org/fa22.org",
  },
  org_default_notes_file = "~/cloud/org/inbox.org",
  mappings = {
    org = {
      org_meta_return = "<Leader><CR>",
    },
  },
  org_hide_emphasis_markers = false,
})
