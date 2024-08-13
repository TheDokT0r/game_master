class_name NPC extends Area2D

@export_category("Sprite Attributes")
@export_file(".*png") var _sprite_path = "res://sprites/NPCs/niv/niv.png"

@export_category("Dialog Attributes")
@export_file("*.ogg") var _dialog_voice = "res://sounds/dialog/sample2.ogg"
@export_multiline var _dialog: Array[String]

@onready var _interaction_area := $InteractionArea
@onready var is_interactable_with_player = false
@onready var _dialog_index = 0
@onready var textbox = preload("res://scenes/HUD/interaction/Textbox.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox._dialog_audio_file = _dialog_voice

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	interact_with_player()
	
func interact_with_player():
	if Input.is_action_just_pressed("INTERACT") and is_interactable_with_player and not textbox.reading_dialog:
		if Global.is_player_in_interaction:
			_dialog_index = _dialog_index + 1
			if _dialog_index >= _dialog.size():
				Global.is_player_in_interaction = false
				textbox.queue_free()
				return
			
			textbox.text = _dialog[_dialog_index]
			
		else:
			Global.is_player_in_interaction = true
			_dialog_index = 0
			textbox.text = _dialog[_dialog_index]
			add_child(textbox)
			
			
				
func _on_body_entered(body):
	if body is Player:
		is_interactable_with_player = true

func _on_body_exited(body):
	if body is Player:
		is_interactable_with_player = false
