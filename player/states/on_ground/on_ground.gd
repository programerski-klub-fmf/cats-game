extends PlayerState


@onready var speed: float


func handle_input(_event: InputEvent) -> void:
	var _is_jump_input: bool = _event.is_action_pressed("jump")
	if _is_jump_input:
		emit_signal("demands_transition_to", "jump")

func physics_update(_delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")

	var direction = (
		player.transform.basis *
		player.yaw_pivot.transform.basis *
		Vector3(input_dir.x, 0, input_dir.y)
	).normalized()
	var target = player.transform.basis * player.yaw_pivot.basis
	var velocity_modifier = player.velocity.length() / speed
	var rotation_amount = player.rotation_speed * _delta * velocity_modifier
	player.transform.basis = player.transform.basis.slerp(
		target,
		rotation_amount
	).orthonormalized()
	player.yaw_pivot.basis = player.yaw_pivot.basis.slerp(
		Basis(),
		rotation_amount
	).orthonormalized()
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x,
			direction.x * speed,
			player.acceleration * _delta
		)
		player.velocity.z = move_toward(
			player.velocity.z,
			direction.z * speed,
			player.acceleration * _delta
		)
	else:
		player.velocity.x = move_toward(
			player.velocity.x,
			0,
			player.acceleration * _delta
		)
		player.velocity.z = move_toward(
			player.velocity.z,
			0,
			player.acceleration * _delta
		)

	player.move_and_slide()

	if not player.velocity:
		emit_signal("demands_transition_to", "idle")
