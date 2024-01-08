extends Node3D

enum GameState {PAUSE, PLAY}
var current_state = GameState.PLAY

func _ready() -> void:
	$Player.state_machine.active = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		match current_state:
			GameState.PLAY:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				$Player.state_machine.active = false
				current_state = GameState.PAUSE
			GameState.PAUSE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				$Player.state_machine.active = true
				current_state = GameState.PLAY

