extends State

@export var hookshot : Node2D
@export var tip : CharacterBody2D
var tip_location : Vector2
var hookshot_position : Vector2 = Vector2.ZERO
var hookshot_direction : Vector2 = Vector2.ZERO
var hookshot_target : Vector2 
@export var hookshot_pull = 105
var hookshot_length = 500
var hookshot_speed = 1
var current_hookshot_length 

const MAX_SPEED = 5

var chain_velocity = Vector2.ZERO
var hookshot_hooked : bool = false
var flying : bool = false
var hooked : bool = false


func _ready():
	current_hookshot_length = hookshot_length

func update(delta):
	Player.gravity(delta)
	update_hookshot()
	
	if hooked:
		chain_velocity = tip_location.normalized() * hookshot_pull
		if chain_velocity.y > 0:
			chain_velocity.y *= 0.55
		else:
			chain_velocity.y *= 1.65
		
		chain_velocity.x = clamp(chain_velocity.x, -MAX_SPEED, MAX_SPEED)
		chain_velocity.y = clamp(chain_velocity.y, -MAX_SPEED, MAX_SPEED)
		
		Player.velocity += chain_velocity
	return null

func enter_state():
	hook()

func exit_state():
	Animation_Player.stop()


func hook():
	var contact_points = []
	for raycast in hookshot.get_children():
		if raycast.is_colliding():
			contact_points.append(raycast.get_collision_point())
			hookshot_hooked = true
	print(contact_points)
	shoot(contact_points[0])

func shoot(hookshot_direction):
#	hookshot_target = hookshot_direction.normalized()
	hookshot_target = Vector2(.5,-.5)
	print(hookshot_target)
	flying = true
	tip.show()
	tip_location = Player.global_position
	print(tip.global_position)

func release_hook():
	flying = false
	hooked = false

func update_hookshot():
	tip.global_position = tip_location
	if flying:
		$Timer.start()
		if tip.move_and_collide(hookshot_target * hookshot_speed):
			hooked = true
			flying = false
	tip_location = tip.global_position


func _on_timer_timeout():
	
	release_hook()
