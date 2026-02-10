# Release Notes

## 2026.02.10
- JSON Viewer filtering upgraded to multi-row filters with `+` / `-`
- Filter matching modes added: `Select ALL matches` and `Select ANY match` (shown when 2+ filters are active)
- Filter fields constrained to `Value` and `Key` with operators: `contains`, `equals`, `not contains`, `not equals`
- Fixed filter behavior to scope matching correctly by selected field (`Key` vs `Value`)
- Fixed boolean filtering so `false` values match correctly
- Filter status updated to explicit switch counts (`Matched switches` / `Showing switches`)
- Filter bar layout refined: fixed-width filter controls, compact +/- buttons, less cluttered action placement
- Added post-export confirmation dialog with `Open File`, `Open Folder`, and `OK`
- Help content updated to document new filter workflow and export behavior

## 2026.02.06
- UI refresh with ttkbootstrap dark theme
- Header title with Aruba-style accent and Help button
- Saved Requests: alphabetized list, right-click delete, and delete button
- Custom Request: save button placed above Recent Requests
- Run button styling: orange default, red while running, fixed size
- Results area grouped and aligned with Connection Targets
- CLI: support `--device` for single-host headless runs
- Saved Requests stored next to EXE, seeded from assets on first run
- Build script updated for new src/assets layout

### Known Notes
- One-file builds still unpack to a temp folder each run (expected PyInstaller behavior)
