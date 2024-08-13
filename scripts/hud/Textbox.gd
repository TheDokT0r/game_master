extends CanvasLayer

@export_category("Text Attributes")
@export_multiline var text = "placeholder"

@export_category("Text Player Attributess")
@export var wait_time = 0.05
@export_file("*.ogg") var _dialog_audio_file = "res://sounds/dialog/sample1.ogg"


@onready var _text_label := $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var dialog_player := $AudioStreamPlayer2D
@onready var reading_dialog = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#await get_tree().physics_frame
	set_dialog_audio_file()
	display_text_process()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _input(event):
	if reading_dialog and Input.is_action_just_pressed("SKIP_INTERACTION"):
		wait_time = 0

func display_text_process():
	_text_label.text = ""
	reading_dialog = true
	for char in text:
		await wait(wait_time)
		_text_label.text += char
		
		if char != "":
			dialog_player.play(0)
	reading_dialog = false
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func set_dialog_audio_file():
	dialog_player.stream = ResourceLoader.load(_dialog_audio_file)
	
func display_textbox():
	self.visible = true
	
func hide_textbox():
	self.visible = false
