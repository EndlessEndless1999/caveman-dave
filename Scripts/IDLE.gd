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
	if Player.hooking:
		return STATES.HOOK
	if Player.casting:
		return STATES.MAGIC
	if Player.parry_input:
		return STATES.PARRY
	return null

func enter_state():
	Animation_Player.play("IDLE")
	Player.can_dash = true
	Camera.update_drag_vertical(false)
