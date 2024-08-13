class_name Player extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

const SPEED = 50

func _process(delta):	
	animation_handler()

func _physics_process(delta):
	var input_direction = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_UP", "MOVE_DOWN")
	velocity = input_direction * SPEED

	move_and_slide()

func animation_handler():
		if Input.is_action_pressed("MOVE_RIGHT"):
			_animated_sprite.flip_h = false
		elif Input.is_action_pressed("MOVE_LEFT"):
			_animated_sprite.flip_h = true
			
		if Input.is_action_pressed("MOVE_RIGHT") or Input.is_action_pressed("MOVE_LEFT") or Input.is_action_pressed("MOVE_UP") or Input.is_action_pressed("MOVE_DOWN"):
			_animated_sprite.play("walking")
		else:
			_animated_sprite.stop()
