extends ActorState


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update(delta):
	if Actor.can_see_enemies():
		return STATES.JUMP_ATTACK
	
	if Actor.character_mover.move_to_position(Actor.start_pos):
		return STATES.JUMP_PATROL
	else:
		#POSSIBLY WILL NEED TO FACE CORRECT DIRECTION
		pass
	return null
