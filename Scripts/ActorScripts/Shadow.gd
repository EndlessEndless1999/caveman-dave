extends CharacterBody2D
class_name Shadow

var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity") 

func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta
	else:
		velocity.y = 0

enum STATES {IDLE, PATROL, ATTACK, HIT, DEAD}
var current_state = STATES.IDLE

#INITIALISABLE VARIABLES
var current_target : Player
@export var character_detector : CharacterDetector
var vision_manager
@export var character_mover : CharacterMover

@export var knockback_velocity : Vector2 = Vector2(100, 0)

var start_pos : Vector2
var start_facing_dir : Vector2

var patrol_points = []
var patrol_index = 0

var hit : bool = false
var stopped : bool = false

@export var attack_range = 50
@export var attack_rate = 1.0
var last_attack_time = 0.0

@export var time_till_idle = 5
var last_time_target_visible = 0.0

var health = 3

@onready var label = $Label
@onready var timer = $IdleTimer
@onready var hit_timer = $HitTimer

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
		STATES.HIT:
			process_hit_state(delta)
			label.text = 'HIT'
		STATES.DEAD:
			process_dead_state(delta)
			label.text = 'DEAD'



func set_idle_state():
	current_state = STATES.IDLE

func set_patrol_state():
	current_state = STATES.PATROL

func set_attack_state():
	current_state = STATES.ATTACK

func set_hit_state():
	current_state = STATES.HIT
	hit_timer.start()

func set_dead_state():
	current_state = STATES.DEAD




func process_idle_state(delta):
	if hit:
		set_hit_state()
	
	if can_see_enemies():
		set_attack_state()
		return 
	
	if character_mover.move_to_position(start_pos):
		set_patrol_state()
	else:
		#POSSIBLY WILL NEED TO FACE CORRECT DIRECTION
		pass

func process_patrol_state(delta):
	if hit:
		set_hit_state()
	
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
	if hit:
		set_hit_state()
		take_damage()
	
	if !is_instance_valid(current_target) or current_target.is_dead():
		update_current_target()
	
	
	if current_target == null:
		return_to_start_state()
		print('TARGET NULL')
		return
	
	
	var our_pos = global_position
	var target_position = current_target.global_position
	
	
	if our_pos.distance_to(target_position) < attack_range:
		execute_attack()
	else: 
		character_mover.move_to_position(target_position)

func process_hit_state(delta):
	
	velocity = knockback_velocity
	
	move_and_slide()
	
	
	if !hit:
		return_to_start_state()
	

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
		print('Not Working')
		return
	attack()

func attack():
	pass

func take_damage():
	health -= 1
	if health <= 0:
		is_dead()

func is_dead():
	queue_free()
	return current_state == STATES.DEAD





func _on_idle_timer_timeout():
	print('TIMEOUT')
	return_to_start_state()



func _on_hit_timer_timeout():
	hit = false
