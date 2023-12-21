extends State

var _finished : bool = false

func enter_state():
	Animation_Player.play("STUN")
	Game.health -= 10
	if Game.health <= 0:
		Player.queue_free()

func exit_state():
	Player.hurt = false
	_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	
	if _finished:
		print('DONE')
		return STATES.MOVE
	
	return null

func is_finished():
	_finished = true
