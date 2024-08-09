extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):	
	animation_handler()

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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
