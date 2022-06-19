local status_ok, orgmode = pcall(require, "orgmode")
if not status_ok then
  return
end

orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = { "~/cloud/org/*" },
  org_default_notes_file = "~/cloud/org/refile.org",
})
