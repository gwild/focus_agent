# ADR 0003: Configuration Policy

## Status
Accepted

## Context
Hardcoded values (PID gains, FFT sizes, sample rates, queue capacities) proliferate throughout codebases, making tuning and deployment difficult.

## Decision
All tunable parameters must come from a single `Config` struct:

- No defaults in runtime paths
- No `unwrap_or(...)` for configuration values
- Fail fast at startup if config is missing
- All "knobs" in one module (`config/knobs.rs`)

## Implementation
- `Config` struct with `#[serde(deny_unknown_fields)]`
- Config loaded at startup, validated, then passed to components
- Constants module for physically justified constants (e.g., protocol frame header size)

## Enforcement
- Policy: `cargo xtask policy` scans for magic number literals in hot modules
- CI: Policy check fails if suspicious literals found outside config
- Code review: Verify all parameters come from Config

## Consequences
- **Positive**: Single source of truth for all parameters, easier deployment
- **Negative**: More verbose than hardcoded values
- **Risk**: If policy not enforced, hardcoded values will reappear

## Notes
- Cannot ban all numeric literals (e.g., array indices, loop bounds)
- Focus on tunable parameters that affect behavior
- Policy scanner uses heuristics (FFT size, sample rate, queue cap patterns)

