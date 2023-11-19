extends State


func update(delta):
	Player.gravity(delta)
	if Player.attack_input:
		return STATES.ATTACK_GROUND
	if Player.movement_input.x != 0:
		return STATES.MOVE
	if Player.jump_input_actuation == true:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	Player.can_dash = true
