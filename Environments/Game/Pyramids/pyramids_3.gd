extends Node2D

@onready var player = $CharacterBody
@onready var start_pos = $start
@onready var end_pos = $end
@onready var transition = $scene_transition

# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.previous_scene == 'jungle':
		player.position = end_pos.position
	else:
		player.position = start_pos.position
		
	Game.previous_scene = 'pyramids_3'





func _on_portal_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/Game/UnderGround/underground_1.tscn")


func _on_portal_2_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/Game/Forest/forest_1.tscn")
