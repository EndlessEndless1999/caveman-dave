extends State

@onready var timer = $Timer

var attacking = true

func update(delta):
	print('JUMP ATTACK')
	if !attacking:
		return STATES.FALL
	return null


func enter_state():
	timer.start()
	Player.velocity.y = Player.ATTACK_JUMP_VELOCITY 

func exit_state():
	attacking = true



func _on_timer_timeout():
	attacking = false
	print('TIMEOUT')
