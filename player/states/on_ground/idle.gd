extends PlayerState


func handle_input(_event: InputEvent) -> void:
	var _is_jump_input: bool = _event.is_action_pressed("jump")
	var _is_move_input: bool = (
		_event.is_action_pressed("left")
		or _event.is_action_pressed("right")
		or _event.is_action_pressed("forwards")
		or _event.is_action_pressed("backwards")
	)
	var _is_run_input: bool = (
		_is_move_input and _event.is_action_pressed("run")
	)

	if _is_jump_input:
		emit_signal("demands_transition_to", "jump")
	elif _is_run_input:
		emit_signal("demands_transition_to", "run")
	elif _is_move_input:
		emit_signal("demands_transition_to", "walk")


