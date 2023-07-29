extends CharacterBody2D

@export var health : float = 100
var player_in_attack_zone = false
var can_take_damage = true

@export var speed = 200
var player_chase = false
var player = null


func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("Walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("Idle")
		
	move_and_slide()
