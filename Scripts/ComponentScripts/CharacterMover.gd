extends Node
class_name CharacterMover



@export var body_to_move : CharacterBody2D

@export var max_speed = 10.0
var movement_vector : Vector2
var goal_pos : Vector2
var jumping : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_instance_valid(body_to_move):
		return
	
	
	var our_pos = body_to_move.global_position
	movement_vector = goal_pos - our_pos
	movement_vector = movement_vector.normalized()
	body_to_move.velocity = movement_vector * max_speed
	
	if jumping:
		body_to_move.velocity.y += -2000
		print('NOW JUMPING')
		jumping = false
	
	body_to_move.gravity(delta)
	
	
	
	body_to_move.move_and_slide()


func move_to_position(pos: Vector2):
	goal_pos = pos
	var our_pos = body_to_move.global_position
	var dist = our_pos.distance_to(pos)
	#TRY DISTANCE SQUARED TO
	return dist < 0.1 * 0.1

func jump():
	jumping = true
