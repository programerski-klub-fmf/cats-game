extends PlayerState


@onready var speed: float

func physics_update(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	print("Input: ", input_dir)
#	var input_dir = Vector3.ZERO
#	input_dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
#	input_dir.z = int(Input.is_action_pressed("forwards")) - int(Input.is_action_pressed("backwards"))

	var direction = (
		player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
		).normalized()
	print("Direction: ", direction)
	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, delta*speed)
		player.velocity.z = move_toward(player.velocity.z, 0, delta*speed)

	print("Velocity:", player.velocity)
	var collision = player.move_and_slide()

	print("After: ", player.velocity)

#	if Input.is_action_just_pressed("jump"):
#		emit_signal("demands_transition_to", "jump")

	if player.velocity == Vector3.ZERO:
		emit_signal("demands_transition_to", "idle")
