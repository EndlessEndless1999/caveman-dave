extends CharacterBody2D
class_name FlyingShadow

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#INITIALISABLES
var current_target : Player
@export var character_detector : CharacterDetector
var vision_manager
@export var character_mover : CharacterMover

var start_pos : Vector2
var start_facing_dir : Vector2

var patrol_points = []
var patrol_index = 0

@export var attack_range = 50
@export var attack_rate = 1.0
var last_attack_time = 0.0

@export var time_till_idle = 5
var last_time_target_visible = 0.0

var health = 3

@onready var label = $Label
@onready var timer = $IdleTimer

#STATE MACHINE
@onready var STATES = $STATES

var current_state = null
var prev_state = null




func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Actor = self
	current_state = STATES.FLY_IDLE
		# INITIALISING REFERENCES IN STATES TO PLAYER
	start_pos = global_position
	
	if has_node("PatrolNodes") and get_node("PatrolNodes").get_child_count() > 0:
		#set patrol state
		for patrol_node in get_node("PatrolNodes").get_children():
			patrol_points.append(patrol_node.global_position)
	else:
		pass
#		set_idle_state()
		#set idle state


func _physics_process(delta):
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()


#VISION FUNCTIONS

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

func is_dead():
	return false
