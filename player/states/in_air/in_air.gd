extends PlayerState


func physics_update(_delta: float) -> void:
	if player.move_and_slide():
		emit_signal("demands_transition_to", "idle")
	else:
		player.velocity.y -= player.gravity * _delta
