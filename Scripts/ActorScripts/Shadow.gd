extends CharacterBody2D
class_name Shadow

enum STATES {IDLE, PATROL, ATTACK, DEAD}
var current_state = STATES.IDLE

#INITIALISABLE VARIABLES
var current_target : Player
@export var character_detector : CharacterDetector
var vision_manager
@export var character_mover : CharacterMover

var start_pos : Vector2
var start_facing_dir : Vector2

var patrol_points = []
var patrol_index = 0

@export var attack_range = 3.0
@export var attack_rate = 1.0
var last_attack_time = 0.0

@export var time_till_idle = 5
var last_time_target_visible = 0.0

var health = 3

@onready var label = $Label
@onready var timer = $IdleTimer

func _ready():
	start_pos = global_position
	
	if has_node("PatrolNodes") and get_node("PatrolNodes").get_child_count() > 0:
		#set patrol state
		for patrol_node in get_node("PatrolNodes").get_children():
			patrol_points.append(patrol_node.global_position)
	else:
		set_idle_state()
		#set idle state

func _process(delta):
	match current_state:
		STATES.IDLE:
			process_idle_state(delta)
			label.text = 'IDLE'
		STATES.PATROL:
			process_patrol_state(delta)
			label.text = 'PATROL'
		STATES.ATTACK:
			process_attack_state(delta)
			label.text = 'ATTACK'
		STATES.DEAD:
			process_dead_state(delta)
			label.text = 'DEAD'



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
		set_patrol_state()
	else:
		#POSSIBLY WILL NEED TO FACE CORRECT DIRECTION
		pass

func process_patrol_state(delta):
	if can_see_enemies():
		set_attack_state()
		timer.start(time_till_idle)
		return 
	
	var our_pos = global_position
	var next_patrol_pos = patrol_points[patrol_index]
	
	character_mover.move_to_position(next_patrol_pos)
#	print(next_patrol_pos)
	
	next_patrol_pos.y = our_pos.y
	if our_pos.distance_to(next_patrol_pos) < 1:
		patrol_index += 1
		patrol_index %= patrol_points.size()
		print(patrol_index)

func process_attack_state(delta):
	if !is_instance_valid(current_target) or current_target.is_dead():
		update_current_target()
	
	if current_target == null:
		return_to_start_state()
		print('TARGET NULL')
		return
	
	
	var our_pos = global_position
	var target_position = current_target.global_position
	
	
	
	if our_pos.distance_to(target_position) < attack_range * attack_range:
		character_mover.move_to_position(our_pos)
		execute_attack()
	else: 
		character_mover.move_to_position(our_pos)

func process_dead_state(delta):
	pass

func return_to_start_state():
	if patrol_points.size() > 0:
		set_patrol_state()
	else:
		set_idle_state()

#IDLE FUNCTIONS

func can_see_enemies():
	return get_visible_enemies().size() > 0
	# RETURNS TRUE IF CAN SEE MORE THAN ONE

func get_visible_enemies():
	var visible_enemies = []
	for enemy in character_detector.get_nearby_enemies():
		if is_instance_valid(enemy):
			print('VISION WORKING')
			var enemy_pos = enemy.global_position
			visible_enemies.append(enemy)
	return visible_enemies

#ATTACK FUNCTIONS
func update_current_target():
	current_target = null
	var visible_enemies = get_visible_enemies()
	if visible_enemies.size() == 0:
		return
	
	var our_pos = global_position
	current_target = visible_enemies[0]
	var dist = -1
	
	for enemy in visible_enemies:
		if !is_instance_valid(enemy) or enemy.is_dead():
			continue
		var pos : Vector2 = enemy.global_position
		var distance = pos.distance_squared_to(our_pos)
		if dist < 0 or dist > distance:
			dist = distance
			current_target = enemy 
			

func execute_attack():
	if current_target == null:
		return
	var cur_time = Time.get_ticks_msec() / 1000.0
	if last_attack_time + attack_rate < cur_time:
		attack()

func attack():
	print('ATTACK')


func is_dead():
	return current_state == STATES.DEAD





func _on_idle_timer_timeout():
	print('TIMER WORKING')
	return_to_start_state()
