extends ActorState


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update(delta):
	if Actor.can_see_enemies():
		return STATES.FLY_ATTACK
		Actor.timer.start(Actor.time_till_idle)
	return null
	
	var our_pos = Actor.global_position
	var next_patrol_pos = Actor.patrol_points[Actor.patrol_index]
	
	Actor.character_mover.move_to_position(next_patrol_pos)
#	print(next_patrol_pos)
	
	next_patrol_pos.y = our_pos.y
	if our_pos.distance_to(next_patrol_pos) < 1:
		Actor.patrol_index += 1
		Actor.patrol_index %= Actor.patrol_points.size()
		print(Actor.patrol_index)
	return null
