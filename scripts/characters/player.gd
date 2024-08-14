class_name Player extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var textbox := preload("res://scenes/HUD/interaction/Textbox.tscn").instantiate()
@export var is_in_interaction = false

@onready var interatables_in_zone: Array[NPC] = []

const SPEED = 50

func _input(event):
	if Input.is_action_just_pressed("INTERACT") and interatables_in_zone.size() > 0:
		var npc = interatables_in_zone[0]
		
		if is_in_interaction:
			npc._dialog_index = npc._dialog_index + 1
			if npc._dialog_index >= npc._dialog.size():
				is_in_interaction = false
				textbox.queue_free()
				return
		
			textbox.text = npc._dialog[npc._dialog_index]
			return
		
		is_in_interaction = true
		npc._dialog_index = 0
		textbox.text = npc._dialog[npc._dialog_index]
		add_child(textbox)

func _process(delta):	
	animation_handler()

func _physics_process(delta):
	if is_in_interaction:
		return
	
	var input_direction = Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_UP", "MOVE_DOWN")
	velocity = input_direction * SPEED

	move_and_slide()

func animation_handler():
		if is_in_interaction:
			_animated_sprite.stop()
			return
	
		if Input.is_action_pressed("MOVE_RIGHT"):
			_animated_sprite.flip_h = false
		elif Input.is_action_pressed("MOVE_LEFT"):
			_animated_sprite.flip_h = true
			
		if Input.is_action_pressed("MOVE_RIGHT") or Input.is_action_pressed("MOVE_LEFT") or Input.is_action_pressed("MOVE_UP") or Input.is_action_pressed("MOVE_DOWN"):
			_animated_sprite.play("walking")
		else:
			_animated_sprite.stop()

func _on_area_entered(area):
	if area is NPC:
		interatables_in_zone.append(area)

func _on_area_exited(area):
	if area is NPC:
		var index = interatables_in_zone.find(area)
		interatables_in_zone.remove_at(index)
