extends State
class_name IdleState

@export var Slimeton: CharacterBody2D

var player = null
var player_in_attack_zone = false
var can_take_damage = false

func _on_area_2d_body_entered(body):
	player = body
	if body.has_method("player"):
		player_in_attack_zone = true
	pass


func _on_area_2d_body_exited(body):
	player = body
	if body.has_method("player"):
		player_in_attack_zone = false
	
func Idle():
	if (player_in_attack_zone == false):
		$AnimatedSprite2D.play("boss_loop")
	
