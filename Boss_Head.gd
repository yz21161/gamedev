extends CharacterBody2D

@export var health : float = 20000

var player = null
var player_in_attack_zone = false


func _on_area_2d_body_entered(body):
	player = body
	
	player_in_attack_zone = true
	
	$AnimatedSprite2D.play("slime_state")

func _on_area_2d_body_exited(body):
	player = body
	$AnimatedSprite2D.play("boss_loop")
