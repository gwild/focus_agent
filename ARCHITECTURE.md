# ARCHITECTURE: generalized design→code enforcement

This document is the canonical home of the generalized design→code enforcement architecture. **focus_agent owns it.** Any repo MAY adopt it; no consumer repo (Milton included) owns or redefines it.

Tracking: [focus_agent#1](https://github.com/gwild/focus_agent/issues/1). Origin discussion: [gwild/milton#4757](https://github.com/gwild/milton/issues/4757) (filed in Milton; content home moved here).

---

## 1. Core principle

**If a rule is not enforced by the compiler or CI, it is not a rule.**

The stack is a **control system**, not documentation or lint theater:

```text
intent  →  mechanical check  →  trusted record  →  runtime under the same constraints
```

- Intent that is never mechanically checked is aspirational. It MUST NOT be described as a rule.
- A check that can be bypassed by an exemption marker, annotation, or "custom behavior" switch is not a check. Escapes are FORBIDDEN.
- Every failure path MUST fail loud: reject, stop, and report. Silent fallbacks and soft landings that continue past a failure are FORBIDDEN.

---

## 2. Repo roles

| Piece | Role |
| --- | --- |
| **focus_agent** ([gwild/focus_agent](https://github.com/gwild/focus_agent)) | Owns the **generalized, reusable** design→code architecture for any repo: principle, reference layout, enforcement ladder, adoption guide, and the SDD-Text contracts in [`docs/sdd/`](docs/sdd/). |
| **xtask-policy** ([gwild/xtask-policy](https://github.com/gwild/xtask-policy)) | **One concrete implementation** of the structure: the policy agent / `cargo xtask policy` pattern, submodule-ready. It implements the architecture; it does not define it. |
| **Graphing** (policy overview) | **Visualization / overview** of the policy surface: which rules exist, how they compose, a human-readable map of the check surface. It is **NOT** a second enforcement engine and MUST NOT gate anything on its own. A role/section only until a dedicated repo or path is named. |
| **attractor** ([gwild/attractor](https://github.com/gwild/attractor)) | **Record keeping + contract verification**: content-addressed, acyclic, tamper-evident substrate for trust and provenance (receipts, invariants). |
| **SDD** ([knutopia/Structured-Design-Documents](https://github.com/knutopia/Structured-Design-Documents)) | Intended design and contracts as a machine- and human-readable model. Upstream of enforcement. |
| **Milton** ([gwild/milton](https://github.com/gwild/milton)) and peers | **Consumers** of the pattern: runtime/orchestration operating under the same invariants. Consumers are not the doc home and MUST NOT redefine the pattern. |

---

## 3. Enforcement ladder: what "done" means for a rule

A rule climbs this ladder. Each step is mechanical; none is satisfied by prose alone.

1. **Named in design.** The rule exists as an SDD / contract (here: [`docs/sdd/`](docs/sdd/), authored from [`docs/sdd/template.sdd`](docs/sdd/template.sdd)).
2. **Encoded as an executable check.** The compiler, xtask-policy, or a CI gate fails closed on violation. Until this step exists, the rule is **aspirational**, and [`docs/sdd/INDEX.md`](docs/sdd/INDEX.md) MUST mark it so (e.g. "SDD drafted; enforcer deferred").
3. **Optionally bound into attractor.** The check result or invariant is recorded as a content-addressed receipt so compliance is verifiable after the fact.
4. **Runtime consumers refuse silent drift.** Consumer runtimes fail loud on violation. There is no "custom behavior" escape, no exemption marker, no annotation override.

A focus_agent **RULE** = step 1 **plus** step 2 (SDD + fail-closed executable check). Steps 3–4 strengthen it; they never substitute for step 2. Only enforcer wiring may be deferred; contract text is never deferred or softened.

---

## 4. Diagram (hub = focus_agent)

```text
SDD (intent/contracts)
        │
        ▼
focus_agent ──architecture + adoption──► xtask-policy (concrete enforcer)
        │                                      │
        │                              Graphing (policy surface overview)
        ▼
attractor (record + verify)
        │
        ▼
consumers: milton | <next repo> | …
```

Graphing hangs off xtask-policy as a read-only view of the check surface. It is not on the enforcement path.

---

## 5. Adoption checklist for a new repo

Generalized from [INSTALL.md](INSTALL.md) and the [xtask-policy](https://github.com/gwild/xtask-policy) path. Every step is required unless marked optional.

1. **Decide invariants.** SSOT boundaries, lock/spawn allowlists, fail-loud requirements. Write them as SDD contracts.
2. **Drop in or submodule xtask-policy; customize `policy.toml`** for the repo's layout (see [INSTALL.md](INSTALL.md)).
3. **Wire CI: the policy check MUST fail the build.** A policy step that only warns, or that CI may skip, does not count.
4. *(Optional)* **Project typed nodes / receipts into attractor** for content-addressed verification.
5. **Document which rules are compiler- vs CI- vs attractor-verified.** Anything with none of the three is aspirational and MUST be labeled as such.
6. **Runtime/agent code consumes the pattern; it does not redefine it.** Local overrides of the contracts or the checks are FORBIDDEN.

---

## 6. Consumers

Consumers adopt the architecture and run under its invariants. They do **not** own it.

- **[gwild/milton](https://github.com/gwild/milton)**: example consumer. Several focus_agent rules are currently enforced through Milton consumer gates (see the enforcement notes in [`docs/sdd/INDEX.md`](docs/sdd/INDEX.md)). That makes Milton an enforcement *site*, not the source of truth for the contract text, which lives here.
- **Next repo**: adopt via §5. Register here when it lands.

---

## 7. Out of scope

- Milton-specific fleet, timer, broker, or deployment details. They belong in the consumer repo.
- Implementing new Milton checks or flipping Milton promised-work flags.
- Expanding attractor or Milton runtime internals beyond the consumer boundary.
- Treating Graphing as a second enforcement engine. It is overview/visualization of policy only.

---

## 8. Cross-references

- SDD-Text contracts: [`docs/sdd/README.md`](docs/sdd/README.md), [`docs/sdd/INDEX.md`](docs/sdd/INDEX.md), [`docs/sdd/template.sdd`](docs/sdd/template.sdd)
- Architecture Decision Records: [`docs/adr/`](docs/adr/)
- Install in another repo: [INSTALL.md](INSTALL.md)
- Concrete enforcer: [gwild/xtask-policy](https://github.com/gwild/xtask-policy)
- Record + verify: [gwild/attractor](https://github.com/gwild/attractor)
- Design model upstream: [knutopia/Structured-Design-Documents](https://github.com/knutopia/Structured-Design-Documents)
- Example consumer: [gwild/milton](https://github.com/gwild/milton)
- Tracking: [focus_agent#1](https://github.com/gwild/focus_agent/issues/1); origin [milton#4757](https://github.com/gwild/milton/issues/4757)
