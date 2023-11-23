extends ActorState
class_name Jump

@export var jump_speed = -50
@onready var timer = $Timer

var timeout : bool = false

func enter_state():
	Actor.velocity.x = 0
	Actor.velocity.y += -1000
	timer.start()
	print('JUMP')
	print(Actor.velocity)

func exit_state():
	timeout = false

func update(delta):
	if Actor.is_on_floor() and timeout:
		return STATES.JUMP_PATROL
	
	Actor.move_and_slide()
	
	return null


func _on_timer_timeout():
	timeout = true
