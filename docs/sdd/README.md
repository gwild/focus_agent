# SDD-Text contracts (focus_agent)

Generalized design→code policy contracts live **here** (`docs/sdd/`), not in Milton. focus_agent owns this text; Milton is a consumer only.

- [INDEX.md](INDEX.md): milton-specs hard rules 1–39, the lead and Before-this-action list, and every RULES.md section, each mapped to an SDD file, a status, and enforcement notes
- A focus_agent **rule** = SDD + fail-closed executable check; otherwise it is aspirational here. Only enforcer wiring is ever deferred, never contract text.
- [template.sdd](template.sdd): authoring template. Failure-path intents MUST be fail-loud / reject / stop. Soft-landing intents that continue past a failure are forbidden.

See [focus_agent#1](https://github.com/gwild/focus_agent/issues/1) and [PR #2](https://github.com/gwild/focus_agent/pull/2).

- Mike: #22 / #32 / #33.
- Ivy security cluster drafted: #4 / #5 / #28 / #29 / #30.
- Elliot: remaining specs (#1–#3, #6–#21, #23–#27, #31, #34–#39, lead) and the RULES.md cluster (`rules-*.sdd`).
- Edits require counsel (Rebecca) review of rule language. No exemption markers, no annotation escapes, no softening of MUST/FORBIDDEN.
