extends State


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.attack_input:
		return STATES.ATTACK_GROUND
	if Player.velocity.x == 0:
		return STATES.IDLE
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.casting:
		return STATES.MAGIC
	return null

func enter_state():
	Player.can_dash = true
	Animation_Player.play('RUN')

func exit_state():
	Animation_Player.stop()
