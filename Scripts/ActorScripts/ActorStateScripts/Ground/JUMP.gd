extends ActorState
class_name Jump

@export var jump_speed = -50
@onready var timer = $Timer

var timeout : bool = false

func enter_state():
	Animation_Player.play('JUMP')
	Actor.character_mover.jump()
	timer.start()
	print('JUMP')
	print(Actor.velocity)

func exit_state():
	timeout = false

func update(delta):
	if timeout:
		return STATES.JUMP_PATROL
	
	Actor.move_and_slide()
	
	return null


func _on_timer_timeout():
	timeout = true
