# Brainstorming

## To do

* Allow getting entities by components efficiently

### Transparent game states

It is useful to have multiple game states in a stack rendered. For example, a pause state or an in-game menu state could still have the state below it rendered. The topmost state (e.g. pause, menu) should likely draw a full-screen semi-opaque black rectangle so that the underlying game is marked as inactive.

## Name entities

Giving entities a name is useful for debugging purposes.

## Triggers

Existence triggers:

* Destroyed (example effect: spawn explosion)
* Created (example effect: spawn flash of light)

Collision triggers:

* Collision start (example effect: decrease health)
* Collision end

Cursor triggers:

* Cursor entered
* Cursor exited
* Mouse pressed
* Mouse released
* Mouse release on entity (example effect: switch to new gamestate)
* Mouse release not on entity
* Mouse dragged

State changes:

* State entered
* State exited

Application triggers:

* Application paused
* Application resumed

Other:

* Position changed
* Always (this might be more of a custom behavior though)

## Research material

* [Insanely Twisted Shadow Planet camera system explanation](https://www.youtube.com/watch?v=aAKwZt3aXQM)
