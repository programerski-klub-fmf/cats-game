class_name StateMachine
extends Node


signal changed_state_to(state_name)

@export var INITIAL_STATE: NodePath

var states_map: Dictionary = {}
var interrupting_states: Array[String] = []

var states_stack: Array[State] = []
var current_state: State = null


func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.demands_transition_to.connect(_change_state)
	_initialize(INITIAL_STATE)

func _initialize(start_state: NodePath) -> void:
	states_stack.push_back(get_node(start_state))
	current_state = states_stack.back()
	current_state.enter()

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

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
#	print(states_stack)
