extends PlayerState


@onready var speed: float


func handle_input(_event: InputEvent) -> void:
	var _is_jump_input: bool = _event.is_action_pressed("jump")
	if _is_jump_input:
		emit_signal("demands_transition_to", "jump")

func physics_update(_delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")

	var direction = (
		player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
		).normalized()
	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.z = move_toward(player.velocity.z, 0, speed)

	var collision = player.move_and_slide()

	if not player.velocity:
		emit_signal("demands_transition_to", "idle")
