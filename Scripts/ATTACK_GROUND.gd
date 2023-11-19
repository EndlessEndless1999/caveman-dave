extends State

@onready var timer = $Timer

var attacking = true

func update(delta):
	print('GROUND ATTACK')
	Player.velocity = Vector2.ZERO
	if !attacking:
		return STATES.IDLE
	return null


func enter_state():
	timer.start()

func exit_state():
	attacking = true



func _on_timer_timeout():
	attacking = false
