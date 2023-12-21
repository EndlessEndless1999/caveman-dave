extends Node2D

@onready var player = $CharacterBody
@onready var start_pos = $start
@onready var end_pos = $end
@onready var transition = $scene_transition






func _on_area_2d_body_entered(body):
	if body is Player:
		Game.abilities.hook = true
		Game.emit_signal('hook')





func _on_portal_body_entered(body):
	if body is Player:
		transition.change_scene("res://Environments/ending.tscn")
