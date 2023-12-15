extends State



@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descend : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1.0

func update(delta):
	player_movement()
	Player.velocity.y += jump_gravity * delta
	#player_movement()
	if Player.attack_input:
		return STATES.ATTACK_JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	
	if Player.hooking:
		return STATES.HOOK
	return null

func enter_state():
	Player.velocity.y = jump_velocity
	Camera.update_drag_vertical(true)


func _on_jump_timer_timeout():
	pass # Replace with function body.



