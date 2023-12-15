extends Node
class_name GameManager


@export var current_checkpoint : Vector2
@export var respawn_scene : String
var previous_scene : String


signal toggle_game_paused(is_paused : bool)




var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal('toggle_game_paused', game_paused)


func _input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		game_paused = !game_paused


#PLAYER STATS

var abilities = {
	dash = false,
	magic = false,
	hook = false,
	shell = false
}

signal health_changed(player_health : int)


var health : int = 50:
	get:
		return health
	set(value):
		health = value
		emit_signal('health_changed', health)




