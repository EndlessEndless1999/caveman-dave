extends CharacterBody2D
class_name Shadow

enum STATES {IDLE, PATROL, ATTACK, DEAD}
var current_state = STATES.IDLE

#INITIALISABLE VARIABLES
var current_target : Player
var character_detector
var vision_manager
var character_mover

var start_pos : Vector2
var start_facing_dir : Vector2

var patrol_points = []
var patrol_index = 0

@export var attack_range = 3.0
@export var attack_rate = 1.0
var last_attack_time = 0.0

@export var time_till_idle = 5.0
var last_time_target_visible = 0.0

var health = 3

func _ready():
	start_pos = global_position
	
	if has_node("PatrolNodes") and get_node("PatrolNodes").get_child_count() > 0:
		#set patrol state
		for patrol_node in get_node("PatrolNodes").get_children():
			patrol_points.append(patrol_node.global_position)
	else:
		pass
		#set idle state

func _process(delta):
	match current_state:
		STATES.IDLE:
			process_idle_state(delta)
		STATES.PATROL:
			process_patrol_state(delta)
		STATES.ATTACK:
			process_attack_state(delta)
		STATES.DEAD:
			process_dead_state(delta)



func set_idle_state():
	current_state = STATES.IDLE

func set_patrol_state():
	current_state = STATES.PATROL

func set_attack_state():
	current_state = STATES.ATTACK

func set_dead_state():
	current_state = STATES.DEAD




func process_idle_state(delta):
	if can_see_enemies():
		set_attack_state()
		return 
	
	if character_mover.move_to_position(start_pos):
		pass
	else:
		#POSSIBLY WILL NEED TO FACE CORRECT DIRECTION
		pass

func process_patrol_state(delta):
	pass

func process_attack_state(delta):
	pass

func process_dead_state(delta):
	pass


#IDLE FUNCTIONS

func can_see_enemies():
	return get_visible_enemies().size() > 0
	# RETURNS TRUE IF CAN SEE MORE THAN ONE

func get_visible_enemies():
	var visible_enemies = []
	for enemy in character_detector.get_nearby_enemies():
		if is_instance_valid(enemy):
			var enemy_pos = enemy.global_position
			if vision_manager.in_vision_cone(enemy_pos) and vision_manager.has_los(enemy_pos):
				visible_enemies.append(enemy)



