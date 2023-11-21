extends State

@onready var timer = $Timer

var attacking = true

func update(delta):
	Player.velocity = Vector2.ZERO
	if !attacking:
		return STATES.IDLE
	return null


func enter_state():
	timer.start()
	STATES.hammer_hit_box.attacking = true

func exit_state():
	attacking = true
	STATES.hammer_hit_box.attacking = false



func _on_timer_timeout():
	attacking = false
