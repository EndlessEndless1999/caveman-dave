extends State


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.attack_input:
		return STATES.ATTACK_JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	return null

func enter_state():
	Player.velocity.y = Player.JUMP_VELOCITY 


func _on_jump_timer_timeout():
	pass # Replace with function body.
