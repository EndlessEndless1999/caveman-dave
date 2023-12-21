extends Panel

@export var transition : CanvasLayer
@export var current_scene : String
# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("_game_over", on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_over():
	show()


func _on_button_pressed():
	print('RESTART')
	transition.change_scene(current_scene)
