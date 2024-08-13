extends Node

var is_player_in_interaction = false

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
