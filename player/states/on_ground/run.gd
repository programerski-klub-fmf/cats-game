extends "on_ground.gd"


func enter() -> void:
	speed = player.run_speed

func update(_delta: float) -> void:
	var _released_run: bool = not Input.is_action_pressed("run")
	if _released_run:
		emit_signal("demands_transition_to", "walk")

