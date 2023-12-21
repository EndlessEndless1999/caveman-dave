extends Area2D
class_name ShadowDamageBox

@export var Actor : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player and body.is_parrying:
		Actor.hit = true
	
	if body is Player and !body.is_parrying:
		body.take_damage()
		
	


func disable():
	monitoring = false


func enable():
	monitoring = true
