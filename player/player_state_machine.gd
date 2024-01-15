extends StateMachine


func _ready():
	states_map = {
		"idle": $Idle,
		"jump": $Jump,
		"walk": $Walk,
		"run": $Run,
		"fall": $Fall,
	}

	super._ready()
