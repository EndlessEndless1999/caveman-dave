extends Area2D
class_name HammerHurtBox

var attacking : bool = false:
	get:
		return attacking
	set(value):
		attacking = value
		set_hitbox(attacking)



func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_hitbox(value):
	monitoring = value
	monitorable = value
	print(monitoring)
	print(monitorable)
