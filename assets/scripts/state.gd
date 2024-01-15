class_name State
extends Node
## A virtual class for isolating code into descreet states, used in a
## [StateMachine] class.
##
## The methods of this class should only be called by their parent
## [StateMachine].
## [br][br]
## [b]Warning:[/b] The [State] class must [b]not[/b] implement the
## [method Node._input], [method Node._process] and
## [method Node._physics_process] methods.

## This signal is emmited when the state exits. The parameter [param state_name]
## is passed to the [method StateMachine.change_state] method, and must be a
## valid string key in [member StateMachine.states_map].
signal demands_transition_to(state_name)


## Called every time when transitioning into this state.
func enter() -> void:
	pass

## Called every time when transitioning out of this state.
func exit() -> void:
	pass

## Called on the current state in [method StateMachine._input].
func handle_input(_event: InputEvent) -> void:
	return

## Called on the current state in [method StateMachine._process].
func update(_delta: float) -> void:
	return

## Called on the current state in [method StateMachine._physics_process].
func physics_update(_delta: float) -> void:
	return

#func _on_animation_finished(_anim_name: String) -> void:
#	return
