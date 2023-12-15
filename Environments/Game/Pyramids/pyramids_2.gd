extends Node2D

@onready var player = $CharacterBody
@onready var start_pos = $start
@onready var end_pos = $end
@onready var transition = $scene_transition

# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.previous_scene == 'pyramids_3':
		player.position = end_pos.position
	else:
		player.position = start_pos.position
		
	Game.previous_scene = 'pyramids_2'


func _on_portal_p_1_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/Game/Pyramids/Pyramids_1.tscn")


func _on_portal_p_2_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/Game/Pyramids/pyramids_3.tscn")
