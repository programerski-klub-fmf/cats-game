extends StateMachine


func _ready():
	states_map = {
		"idle": $Idle,
		"jump": $Jump,
	}

	super._ready()
