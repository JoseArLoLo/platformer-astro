extends CharacterBody2D


const SPEED: int = 150
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# MOVE THE PLAYER
	var move_vector: int = int(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	if move_vector:
		velocity.x = move_toward(velocity.x, move_vector * SPEED, 800 * delta)
		animated_sprite_2d.flip_h = (move_vector == -1)
	else:
		velocity.x = move_toward(velocity.x, move_vector * SPEED, 1000 * delta)
		
	if is_on_floor() and velocity.x != 0: animated_sprite_2d.play("run")
	elif is_on_floor() and velocity.x == 0: animated_sprite_2d.play("idle")
	
	# APPLY GRAVITY
	if not is_on_floor(): 
		velocity.y += (500 * delta)
		animated_sprite_2d.play("fall")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor(): 
		velocity.y = -250
	
	if velocity.y < 0: animated_sprite_2d.play("jump")
	
	move_and_slide()
