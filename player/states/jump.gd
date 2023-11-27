extends PlayerState


func enter() -> void:
	player.velocity.y = player.jump_velocity

func physics_update(_delta: float) -> void:
	if player.move_and_slide():
		emit_signal("demands_transition_to", "idle")
	else:
		player.velocity.y -= player.gravity * _delta
