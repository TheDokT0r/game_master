class_name NPC extends CharacterBody2D

@export_category("Sprite Attributes")
@export_file(".*png") var _sprite_path = "res://sprites/NPCs/niv/niv.png"

@export_category("Dialog Attributes")
@export_file("*.ogg") var _dialog_voice = "res://sounds/dialog/sample2.ogg"
@export_multiline var _dialog: Array[String]

@onready var _sprite := Sprite2D
@onready var _dialog_index = 0
@onready var textbox = preload("res://scenes/HUD/interaction/Textbox.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox._dialog_audio_file = _dialog_voice
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
