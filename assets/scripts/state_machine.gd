class_name StateMachine
extends Node
## A virtual class for managing objects states, and transitions between them.
##
##


## This signal is emited in the [method _change state] method, when the state
## machine has change to a new state [param state_name]. This string corresponds
## to one in [member states_map].
signal changed_state_to(state_name: String)

## Initial state must be set manually in the Inspector tab.
@export var INITIAL_STATE: NodePath

## A dictionary of states with [String] for keys and [State] as values.
var states_map: Dictionary = {}
## An array of states that are allowed to interrupt other states. Each state is
## given as a [String] corresponding to [member states_map].
## [br][br]
## [b]Note:[/b] Only the StateMachine can demand the transition to an
## interrupting state.
var interrupting_states: Array[String] = []

## An array for storing interupted states. They are recovered by passing the
## string [code]"previous"[/code] to the signal
## [signal State.demands_transition_to] of the interrupting state.
var states_stack: Array[State] = []
## Pointer to the currently active state.
var current_state: State = null
# TODO: Do we need both current_state and states_stack? Instead: call from stack

## A switch for toggling of the state machine. If set to [code]false[/code], the
## methods [method _input], [method _process] and
## [method _physics_process] will [code]pass[/code].
var active: bool = false

## The function [code]await[/code]s the state machine's parent
## node. It then connects each child node's signal
## [signal State.demands_transition_to] to [method _change_state]
## method, and calls the method [method _initialize] on
## [member INITIAL_STATE].
## [br][br]
## Inherited from [Node].
func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.demands_transition_to.connect(_change_state)
	_initialize(INITIAL_STATE)

## Adds the [param start_state]'s corresponding [State] child node to the
## [member states_stack], and sets it at as the [member current_state]. It then
## calls the [method State.enter] method on the [member current_state].
func _initialize(start_state: NodePath) -> void:
	states_stack.push_back(get_node(start_state))
	current_state = states_stack.back()
	current_state.enter()

## Transitions from the current state to an appropriate state. This method is
## called when the [member current_state] emits the
## [signal State.demands_transition_to] signal, with the [String] parameter
## [param state_name] provided by the signal and corresponding to a key in the
## [member states_map] dictionary.
## [br][br]
## The method first exits the [member current_state] with its
## [method State.exit] method. It then pops the new state to the back of the
## [member states_stack], unless the new state's name is in
## [member interrupting_states]. Then the new state is pushed to the back of
## [member states_stack], unless the current state is an interrupting state with
## (in this case [param state_name] will be [code]"previous"[/code]). The back
## state on the [member states_stack] is set as the [member current_state], and
## its [method State.enter] called, unless the previous state was an
## interrupting state ([param state_name] is [code]"previous"[/code]).
func _change_state(state_name: String) -> void:
	current_state.exit()

	if not state_name in interrupting_states:
		states_stack.pop_back()
	if not state_name == "previous":
		states_stack.push_back(states_map[state_name])
#
#	if state_name == "previous":
#		states_stack.pop_back()
#	if state_name in interrupting_states:
#		states_stack.push_back(states_map[state_name])
#	else:
#		states_stack.pop_back()
#		states_stack.push_back(states_map[state_name])

	current_state = states_stack.back()
	emit_signal("changed_state_to", current_state)

	if state_name != "previous":
		current_state.enter()

# state has changed to current state

# TODO: Do we need both current_state and active?

## Inherited [method Node._input] method. The state machine delegates the
## handling of [param event] to the [member current_state]
## by calling the [method State.handle_input] method.
func _input(event: InputEvent) -> void:
	if current_state and active:
		current_state.handle_input(event)

## Inherited [method Node._process] method. The state machine insures that at
## any time only one child [State] updates. It calls the
## [method State.update] method with the parameter [param delta] on the
## [member current_state].
func _process(delta: float) -> void:
	if current_state and active:
		current_state.update(delta)

## Inherited [method Node._physics_process] method. The state machine insures
## that at any time only one child [State] updates. It calls the
## [method State.physics_update] method with the parameter [param delta] on the
## [member current_state].
func _physics_process(delta: float) -> void:
	if current_state and active:
		current_state.physics_update(delta)
