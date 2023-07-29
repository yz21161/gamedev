extends CharacterBody2D

@export var speed = 200
@export var health : float = 1000
@export var JUMP_VELOCITY : float = -250

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var state
var state_factory

func ready():
	state_factory = StateFactory.new()
	change_state("IdleState")
	Idle()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup ("change_state", $AnimatedSprite2D, self)
	state.name = "current_state"
	add_child(state)
