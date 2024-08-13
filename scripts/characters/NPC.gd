class_name NPC extends Area2D

@export_category("Sprite Attributes")
@export_file(".*png") var _sprite_path = "res://sprites/NPCs/niv/niv.png"

@export_category("Dialog Attributes")
@export_file("*.ogg") var _dialog_voice = "res://sounds/dialog/sample2.ogg"
@export_multiline var _dialog: Array[String]

@onready var _interaction_area := $InteractionArea
@onready var dialog_index = 0
@onready var is_interactable_with_player = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("INTERACT") and is_interactable_with_player:
		interact_with_player()
	
func interact_with_player():
	var textbox = preload("res://scenes/HUD/interaction/Textbox.tscn").instantiate()
	textbox._dialog_audio_file = _dialog_voice
	textbox.text = _dialog[dialog_index]
	add_child(textbox)



func _on_body_entered(body):
	if body is Player:
		is_interactable_with_player = true


func _on_body_exited(body):
	if body is Player:
		is_interactable_with_player = false
