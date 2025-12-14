// Runtime crate: All side effects live here
// Owns: threads, async, sockets, serial I/O
// Runs the state owner loop

mod scheduler;

use core::StateOwner;

fn main() {
    // State owner will run here
    let _state_owner = StateOwner::new();
    println!("Runtime starting...");
}
