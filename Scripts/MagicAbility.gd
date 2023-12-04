extends Magic
class_name MagicAbility

@export var projectile_scene : PackedScene
@export var instancing_offset : Vector2


func use(magic_user : Node2D):
	var instance : Projectile = projectile_scene.instantiate()
	magic_user.get_parent().add_child(instance)
	
	var facing_sign = magic_user.last_direction
	
	var instance_position = magic_user.global_position
	instance.global_position = instance_position
	
	instance.launch(magic_user.last_direction)
	
	return true
