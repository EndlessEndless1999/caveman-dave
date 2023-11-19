extends Area2D
class_name CharacterDetector

var nearby_enemies = []

func _physics_process(delta):
	update_nearby_characters()


func update_nearby_characters():
	nearby_enemies = []
	for body in get_overlapping_bodies():
		if body is Player:
			nearby_enemies.append(body)
		else:
			return

func get_nearby_enemies():
	return nearby_enemies

