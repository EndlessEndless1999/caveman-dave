extends Control
class_name PauseMenu


func _ready():
	hide()
	Game.connect('toggle_game_paused', on_game_manager_toggle_game_paused)



func _process(delta):
	pass


func on_game_manager_toggle_game_paused(is_paused : bool):
	if is_paused:
		show()
	else:
		hide()


func _on_resume_button_pressed():
	Game.game_paused = false


func _on_exit_button_pressed():
	get_tree().quit()
