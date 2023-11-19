extends State

@onready var timer = $Timer

var attacking = true

func update(delta):
	print('FALL ATTACK')
	if !attacking:
		return STATES.FALL
	return null


func enter_state():
	timer.start()

func exit_state():
	attacking = true



func _on_timer_timeout():
	attacking = false
