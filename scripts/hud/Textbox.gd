extends CanvasLayer

signal _on_text_changes

@export_category("Text Attributes")
@export_multiline var text = "placeholder" :
	get:
		return text
	set(new_value):
		text = new_value
		_on_text_changes.emit()
		
@export_category("Text Player Attributess")
@export var default_wait_time = 0.05
@export_file("*.ogg") var _dialog_audio_file = "res://sounds/dialog/sample1.ogg"
@export var reading_dialog = false


@onready var text_label := $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var end_label := $MarginContainer/MarginContainer/HBoxContainer/End
@onready var dialog_player := $AudioStreamPlayer2D
@onready var symbol_timer := $SymbolTimer
@onready var wait_time = default_wait_time


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_text_changes.connect(_on_text_changes_signal_func)
	
	set_dialog_audio_file()
	display_text_process()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_text_changes_signal_func():
	wait_time = default_wait_time
	text_label.text = ""
	display_text_process()

func _input(event):
	if reading_dialog and Input.is_action_just_pressed("SKIP_INTERACTION"):
		wait_time = 0

func display_text_process():
	text_label.text = ""
	reading_dialog = true
	for char in text:
		await Global.wait(wait_time)
		text_label.text += char
		
		if char != "":
			dialog_player.play(0)
	reading_dialog = false

func set_dialog_audio_file():
	dialog_player.stream = ResourceLoader.load(_dialog_audio_file)
	
func display_textbox():
	self.visible = true
	
func hide_textbox():
	self.visible = false

func _on_symbol_timer_timeout():
	if end_label.text == "V":
		end_label.text = "v"
	else:
		end_label.text = "V"
