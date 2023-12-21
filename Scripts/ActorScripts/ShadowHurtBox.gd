extends Area2D
class_name  ShadowHitBox

@export var Actor : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	print('AREA ENTERED')
	if area is HammerHurtBox:
		print('HURT BY HAMMER!')
		Actor.hit = true 
	else:
		print('NOT WORKING')
	if area is FireMagic:
		Actor.die()



func _on_body_entered(body):
	pass # Replace with function body.
