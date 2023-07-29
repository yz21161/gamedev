class_name StateFactory

var states

func _init():
	states = {"Idle": IdleState,"Slime": SlimeState}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No State", state_name, "In State Factory")
