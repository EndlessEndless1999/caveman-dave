extends State

@onready var timer = $Timer
@onready var audio = $AudioStreamPlayer

var attacking = true

func update(delta):
	Player.velocity = Vector2.ZERO
	if !attacking:
		return STATES.IDLE
	return null


func enter_state():
	audio.play()
	STATES.hammer_hit_box.attacking = true
	Animation_Player.play('ATTACK')

func exit_state():
	attacking = true
	STATES.hammer_hit_box.attacking = false
	Animation_Player.stop()



func animation_finished():
	attacking = false
