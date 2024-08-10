class_name NPC extends StaticBody2D

@export_category("Sprite Attributes")
@export_file(".*png") var _sprite_path = "res://sprites/NPCs/niv/niv.png"
@export var shape: Shape2D

@export_category("Dialog Attributes")
@export_file("*.ogg") var _dialog_voice = "res://sounds/dialog/sample2.ogg"
@export_multiline var _dialog: Array[String]

@onready var dialog_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
