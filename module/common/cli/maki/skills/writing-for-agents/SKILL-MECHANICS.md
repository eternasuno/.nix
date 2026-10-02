# Skill mechanics

## Verified Maki behavior

These facts were checked against the installed Maki 0.5.7 build source. Recheck the active version and its skill plugin before relying on them for a different deployment.

- Discovery scans immediate subdirectories containing `SKILL.md` in configured/global/project skill locations. Later entries with the same name replace earlier ones.
- YAML frontmatter supplies `name` and `description`; the name defaults to the directory name, and description to an empty string. Keep names aligned with directory names and descriptions concise, with capability and distinct trigger conditions.
- Discovery reads files internally, but the skill tool's startup description lists names/descriptions, not full bodies. The description is a discovery hint, not an enforcement mechanism.
- The `skill` tool rediscovers by name and returns the body without frontmatter. It does not execute Markdown or automatically load linked references.
- Direct file reading accesses the file independently of named skill invocation, subject to ordinary permissions. It is not a frontmatter-aware invocation gate.
- This version does not implement `disable-model-invocation` or a user-only skill category. Those fields do not hide descriptions, prevent model invocation, or block direct reads. Do not use them as access controls.
- Skill directories are separate from command discovery. A slash command requires a separately configured command; a skill name alone does not establish one.

## Evidence and rechecking

Installed-build source functions:

- `plugins/skill/init.lua`: `scan_skill_dir`, `discover_skills`, startup tool description, and named tool handler.
- `plugins/skill/skill_helpers.lua`: `parse_frontmatter` and `build_skill_list`.
- `plugins/read/init.lua`: path-based read handler.
- `maki-agent/src/command.rs`: command-directory discovery.

Identify the active binary/version and its build source rather than assuming a separate checkout or the repository lock is the installed revision. Inspect supported fields and loading paths before documenting invocation behavior. Unsupported metadata is not a safety boundary.

## Packaging

Keep the main description focused on when to use the skill. Keep supporting files inside its directory with explicit reading conditions. Avoid router skills and invocation-based splitting unless the actual runtime and a demonstrated independent need justify them; a plain conditional reference often suffices.
