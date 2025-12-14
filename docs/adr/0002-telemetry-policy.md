# ADR 0002: Telemetry and Event Policy

## Status
Accepted

## Context
Multiple streams (GUI, logging, control) need to consume state updates without blocking the control loop. Real-time display and plotting must not backpressure producers.

## Decision
We adopt explicit queue policies per consumer:

- **GUI/plotting**: Lossy keep-latest (drop intermediate frames)
- **Logging**: Bounded + batch (drop low-priority telemetry when full)
- **Control outputs**: Lossless, bounded, acked (never drop safety-critical commands)

## Implementation
- GUI subscribes to telemetry with keep-latest semantics
- Logger receives events via bounded channel with batching
- Control commands use bounded queue with fail-fast on overflow

## Enforcement
- Policy: No unbounded channels in production code
- Code review: Verify queue policies match requirements
- Testing: Verify backpressure behavior under load

## Consequences
- **Positive**: Control loop immune to GUI/DB stalls, predictable latency
- **Negative**: GUI may miss frames (acceptable for visualization)
- **Risk**: If policies not enforced, blocking can re-enter control path

## Notes
- "Sync" means "align by epoch ID," not "block until perfect"
- GUI rendering must never backpressure the producer
- Real-time plots are inherently "best-effort"

