extends State

var parrying : bool = false

func enter_state():
	parrying = true
	$Timer.start()
	print('PARRYING')

func exit_state():
	print('Not Parrying')

func update(delta):
	if !parrying:
		return STATES.IDLE
	
	return null


func _on_timer_timeout():
	print('TIMEOUT')
	parrying = false
