extends State

var parrying : bool = false

func enter_state():
	Player.velocity.x = 0
	Player.is_parrying = true
	Animation_Player.play('BEETLE')
	parrying = true
	$Timer.start()
	print('PARRYING')

func exit_state():
	print('Not Parrying')

func update(delta):
	if Player.hurt and !Player.is_parrying:
		return STATES.HIT
	
	if !parrying:
		return STATES.IDLE
	
	return null

func end():
	parrying = false

func not_parrying():
	Player.is_parrying = false
