extends Area2D

@onready var player = $"../CharacterBody"




func _on_body_entered(body):
	if body == player:
		DefaultTransition.change_scene("res://Scenes/Entities/Player/Character.tscn")
