extends Node2D
class_name Checkpoint

var spawn_location = self.global_position

var current_checkpoint : bool = false

@export var scene_path : String 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interact_area_body_entered(body):
	if body is Player:
		#GameManager.current_checkpoint = self.global_position
		#GameManager.respawn_scene = scene_path
		#Do with signals instead.
