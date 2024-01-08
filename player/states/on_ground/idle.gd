extends PlayerState


func update(_delta: float) -> void:
	var _is_jump_input: bool = Input.is_action_pressed("jump")
	var _is_move_input: bool = (
		Input.is_action_pressed("left")
		or Input.is_action_pressed("right")
		or Input.is_action_pressed("forwards")
		or Input.is_action_pressed("backwards")
	)
	var _is_moving: bool = player.velocity.x != 0 or player.velocity.z != 0

	if _is_jump_input:
		emit_signal("demands_transition_to", "jump")
	elif _is_move_input or _is_moving:
		emit_signal("demands_transition_to", "walk")
