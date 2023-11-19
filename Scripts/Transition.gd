extends Area2D

@onready var player = $"../CharacterBody"

@export var target_scene : String


func _on_body_entered(body):
	if body == player:
		DefaultTransition.change_scene(target_scene)
