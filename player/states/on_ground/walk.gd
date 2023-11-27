extends "on_ground.gd"


func enter() -> void:
	speed = player.walk_speed

func update(_delta: float) -> void:
	var _is_run_input: bool = Input.is_action_pressed("run")
	if _is_run_input:
		emit_signal("demands_transition_to", "run")
