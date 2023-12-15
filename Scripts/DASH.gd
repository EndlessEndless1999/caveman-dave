extends State


@onready var ghost_timer = $GhostTimer
var ghost_scene = preload("res://Scenes/Components/dash_ghost.tscn")

var dash_direction = Vector2.ZERO
var dash_speed = 240
var dashing = false

@export var dash_duration = .2
@onready var DashDuration_Timer = $DashDuration

func update(delta):
	if !dashing:
		return STATES.FALL 
	return null

func enter_state():
	ghost_timer.start()
	Player.can_dash = false
	dashing = true
	DashDuration_Timer.start(dash_duration)
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	Player.velocity = dash_direction.normalized() * dash_speed

func exit_state():
	ghost_timer.stop()
	dashing = false
	pass

func instance_ghost():
	var ghost : Sprite2D = ghost_scene.instantiate()
	get_parent().add_child(ghost)
	
	ghost.global_position = Player.global_position

func _on_timer_timeout():
	dashing = false
	pass


func _on_ghost_timer_timeout():
	instance_ghost()
