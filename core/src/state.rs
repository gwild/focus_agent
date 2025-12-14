// MachineState is PRIVATE - cannot be named outside this module
// Only Command, Snapshot, and Event are public

/// Authoritative machine state (private)
struct MachineState {
    // State fields will be added here
}

/// Commands for mutating state (public)
#[derive(Debug, Clone)]
pub enum Command {
    // Command variants will be added here
}

/// Snapshot of current state (public, read-only)
#[derive(Debug, Clone)]
pub struct Snapshot {
    // Snapshot fields will be added here
}

/// Events emitted by state transitions (public)
#[derive(Debug, Clone)]
pub enum Event {
    // Event variants will be added here
}

impl MachineState {
    /// Create a new machine state
    pub fn new() -> Self {
        MachineState {}
    }

    /// Apply a command and return resulting events
    /// This is the ONLY way to mutate state
    pub fn apply_command(&mut self, _cmd: Command) -> Vec<Event> {
        // Command handling will be implemented here
        // For now, return empty events since Command is empty
        vec![]
    }

    /// Create a snapshot of current state
    pub fn snapshot(&self) -> Snapshot {
        Snapshot {}
    }
}

impl Default for MachineState {
    fn default() -> Self {
        Self::new()
    }
}

/// State owner handle - allows runtime to interact with state without direct access
pub struct StateOwner {
    state: MachineState,
}

impl StateOwner {
    /// Create a new state owner
    pub fn new() -> Self {
        StateOwner {
            state: MachineState::new(),
        }
    }

    /// Apply a command and return resulting events
    pub fn apply_command(&mut self, cmd: Command) -> Vec<Event> {
        self.state.apply_command(cmd)
    }

    /// Create a snapshot of current state
    pub fn snapshot(&self) -> Snapshot {
        self.state.snapshot()
    }
}

impl Default for StateOwner {
    fn default() -> Self {
        Self::new()
    }
}
