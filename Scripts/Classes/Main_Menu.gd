extends Node2D
class_name MainMenu

@onready var background = $Parallax/ParallaxBackground
@onready var animation = $AnimationPlayer
@onready var transition = $scene_transition

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("start")
	Game.health = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset.x += 1.3


func _on_start_button_pressed():
	animation.play("stop")
	await animation.animation_finished
	transition.change_scene("res://Environments/Game/tutorial_level.tscn")


func _on_controls_pressed():
	pass # Replace with function body.
