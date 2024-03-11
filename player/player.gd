class_name Player
extends CharacterBody3D


@export var mouse_sensitivity := 0.001
@export var yaw_speed := 1.0
@export var pitch_speed := 1.0

@export var acceleration := 20.0
@export var walk_speed := 1.0
@export var run_speed := 9.0
@export var jump_velocity := 6.0
@export var rotation_speed := 8.0

var yaw_input := 0.0
var pitch_input := 0.0

@onready var state_machine := $PlayerStateMachine
@onready var yaw_pivot := $YawPivot
@onready var pitch_pivot := $YawPivot/PitchPivot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	yaw_pivot.rotate_y(yaw_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(
		pitch_pivot.rotation.x,
		deg_to_rad(-60),
		deg_to_rad(10)
	)
	yaw_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			yaw_input = - event.relative.x * mouse_sensitivity * yaw_speed
			pitch_input = - event.relative.y * mouse_sensitivity * pitch_speed
