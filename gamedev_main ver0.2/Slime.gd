extends CharacterBody2D

@export var speed : float = 100.0
var Jump_Velocity = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 100

var direction = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta
	move_enemy()
	direction = move_and_slide()

func move_enemy():
	if is_on_wall():
		velocity.x *= -1
	

func take_damage(damage_amount):
	health -= damage_amount
	if health <= 0:
		enemy_defeated()

func enemy_defeated():
	queue_free()
