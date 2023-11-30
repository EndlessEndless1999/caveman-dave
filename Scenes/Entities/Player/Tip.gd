extends Node2D
class_name Chains

@export var player : Player

var direction : Vector2
var tip : Vector2

const SPEED = 10

var flying : bool = false
var hooked : bool = false

func shoot(dir : Vector2):
	direction = dir.normalized()
	flying = true
	tip = player.global_position

func release():
	flying = false
	hooked = false

func _process(delta):
	self.visible = flying or hooked
	
	if not self.visible:
		return
	
	var tip_location = to_local(tip)

func _physics_process(delta):
	$Tip.global_position = tip
	if flying:
		if $Tip.move_and_collide(direction * SPEED):
			hooked = true
			flying = false
	tip = $Tip.global_position
		
