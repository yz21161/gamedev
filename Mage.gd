extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
@export var health : float = 10000
var player_alive = true
@export var double_jump_velocity : float = -100

#var attack_in_progress = false

@export var nSPEED : float = 300.0
@export var JUMP_VELOCITY : float = -250

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction :Vector2 = Vector2.ZERO
var was_in_air : bool = false
var has_double_jumped : bool = false

func _physics_process(delta):
#	attack()
	enemy_attack()
	if health <= 0:
		player_alive = false
		health = 0
		print("player has died")
		self.queue_free()

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		was_in_air = true
		
		if was_in_air == true:
			land()
			
		was_in_air = false
	else:
		has_double_jumped = false
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		if is_on_wall() and Input.is_action_just_pressed("jump"):
			jump()
			
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true
		
	direction = Input.get_vector("left","right","up","down") 
	if direction:
		velocity.x = direction.x * nSPEED
	else:
		velocity.x = move_toward(velocity.x, 0, nSPEED)
		
	move_and_slide()
	update_animation()
#	attack()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("Walking Animation")
#		elif attack_in_progress == false:
		else:
			animated_sprite.play("Idle Animation")
			
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = JUMP_VELOCITY
	animated_sprite.play("Jump Start Animation")
	animation_locked = true

func land():
	animated_sprite.play("Jump End Animation")
	animation_locked = true

func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "Jump End Animation"):
		animation_locked = false

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
#
#func attack():
#	if Input.is_action_just_pressed("attack"):
#		if direction.x > 0:
#			animated_sprite.flip_h = false
#			animated_sprite.play("justAttack")
##			$damage_dealing_cooldown.start()
#		elif direction.x < 0:
#			animated_sprite.flip_h = true
#			animated_sprite.play("justAttack")
##			$damage_dealing_cooldown.start()
#		print_debug("attack")
#		global.player_current_attack = true
##		attack_in_progress = true


func _on_damage_dealing_cooldown_timeout():
	$damage_dealing_cooldown.stop()
	global.player_current_attack = false
#	attack_in_progress = false


func _on_deadzone_body_entered(body):
	print("entered")
	if body.name == "Mage":
		position = Vector2(1,2)


func _on_freefall_body_entered(body):
	if body.name == "Mage":
		velocity.y = gravity -500
