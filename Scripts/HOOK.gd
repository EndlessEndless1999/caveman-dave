extends State


#CLAMP SPEEDS AND TWEAK VALUES

@onready var timer = $Timer
@export var raycasts : Node2D


var timeout : bool = false

func enter_state():
	print('ENTERING HOOK')
	timer.start()

	
	Player.hook_pos = get_hook_pos()
	
	if Player.hook_pos:
		Player.hooked = true
		Player.current_rope_length = Player.global_position.distance_to(Player.hook_pos)

func update(delta):
	#draw_hook()
	
	if timeout:
		return STATES.FALL
	
	if Player.hooked:
		Player.gravity(delta)
		swing(delta)
		
		Player.velocity *= 0.95 #SPEED OF SWING
		
	
	return null

func exit_state():
	timeout = false

func get_hook_pos():
	for raycast : RayCast2D in raycasts.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()

func swing(delta):
	var radius = Player.global_position - Player.hook_pos
	
	print(radius.length())
	
	
	if Player.velocity.length() < 0.1 or radius.length() < 10: 
		print('STOPPING')
		return
	
	var angle = acos(radius.dot(Player.velocity) / (radius.length() * Player.velocity.length()))
	
	var rad_velocity = cos(angle) * Player.velocity.length()
	Player.velocity += radius.normalized() * -rad_velocity
	
	if Player.global_position.distance_to(Player.hook_pos) < Player.current_rope_length:
		print('ROPE LENGTH')
		Player.velocity += Player.hook_pos + radius.normalized() * Player.current_rope_length
		
	if Player.global_position.x > Player.hook_pos.x:
		print('RETURNING')
		return
		
	Player.velocity += (Player.hook_pos - Player.global_position).normalized() * 10000 * delta 
	
	Player.velocity.x = clamp(Player.velocity.x, -300, 1000)
	Player.velocity.y = clamp(Player.velocity.y, -200, 200)
	
	


func draw_hook():
	var pos = Player.global_position 
	
	if Player.hooked:
		Player.draw_line(Vector2(0, -16), Player.to_local(Player.hook_pos), Color(0.35, 0.7, 0.9), 3, true) #cyan
	else:
		return
		
	var colliding = raycasts.is_colliding()
	var collide_point = raycasts.get_collision_point()
	
	if colliding and pos.distance_to(collide_point) < Player.rope_length:
		Player.draw_line(Vector2(0, -16), Player.to_local(collide_point), Color(1,1,1,0.25), 0.5, true) #white


func _on_timer_timeout():
	timeout = true
