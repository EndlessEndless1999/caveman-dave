extends Node2D
class_name Projectile

@export var speed : float = 100.0
var launched : bool = false

var direction : Vector2

func _ready():
	if launched == false:
		push_warning("Projectile created but launch not called.")

func _physics_process(delta):
	position.x += direction.x * speed * delta
	

func launch(p_direction : Vector2):
	direction = p_direction
	launched = true
