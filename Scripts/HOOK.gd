extends State

@export var hookshot : Node2D

func update(delta):
	Player.gravity(delta)
	return null

func enter_state():
	hook()

func exit_state():
	Animation_Player.stop()


func hook():
	Player.hookshot_position = get_hookshot_position()
	if Player.hookshot_position:
		Player.hooked = true
		Player.current_hookshot_length = Player.global_position.distance_to(Player.hookshot_position)


func get_hookshot_position():
	for raycast in hookshot.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()
	
