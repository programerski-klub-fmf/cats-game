extends Marker3D

@export var step_target: Node3D
@export var step_distance: float = 0.5
@export var step_height: float = 0.1

# TODO: step_distance should be at topmost player level

# TODO: this logic should be better integreted into PlayerStateMachine

func _process(delta: float) -> void:
	var distance_to_step_target = abs(
		global_position.distance_to(step_target.global_position)
		)
	if distance_to_step_target > step_distance:
		step()

func step():
	var target_position = step_target.global_position
	var half_way = (global_position + target_position) / 2
	var half_step_time = 0.15

	var t = get_tree().create_tween()
	t.tween_property(
		self,
		"global_position",
		half_way + step_height * owner.basis.y,
		half_step_time
	)
	t.tween_property(
		self,
		"global_position",
		target_position - 0.2 * owner.basis.z,
		half_step_time
	)
