extends Node2D

@onready var player = $CharacterBody
@onready var start_pos = $start
@onready var end_pos = $end
@onready var transition = $scene_transition

# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.previous_scene == 'pyramids_2':
		player.position = end_pos.position
	else:
		player.position = start_pos.position
		
	Game.previous_scene = 'pyramids_1'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_area_2d_body_entered(body):
	if body is Player:
		Game.abilities.dash = true
		Game.emit_signal('dash')





func _on_portal_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/Game/Pyramids/pyramids_2.tscn")
