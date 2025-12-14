// Core crate: Pure state machine
// NO tokio, NO std::sync, NO async, NO I/O
// Only state transitions and validation

pub mod state;

pub use state::{Command, Event, Snapshot, StateOwner};
