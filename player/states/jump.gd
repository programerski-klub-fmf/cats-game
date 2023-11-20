extends PlayerState


func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if player.is_on_floor():
		emit_signal("demands_transition_to", "idle")
	else:
		player.velocity.y -= player.gravity * delta
