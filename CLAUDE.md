# CLAUDE.md — GlassineOS/protocols

Interfaces between GlassineOS components (see `README.md`). Every change: run
`make check`.

- A change is backwards compatible or raises the version (`version`/`since` in the XML,
  a capability bit in the header). Never change the meaning of an existing request,
  event, message or field.
- The consumers listed in README's "Status" still carry copies: change them in the same
  release.
- Commits carry an `Assisted-by:` or `Co-Authored-By:` trailer. Never add
  `Signed-off-by`. Run `.glassine/org/scripts/safety-scan.sh --staged` before committing.
- Organization guidance for coding agents, including the project knowledge search
  (run `git submodule update --init` if the import below is missing):

@.glassine/org/AGENTS.md
