extends CharacterBody2D
class_name Player


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_value = ProjectSettings.get_setting("physics/2d/default_gravity")

# player input 
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false

var attack_input = false

#player_movement
const SPEED = 70.0
const MAX_SPEED = 200
const JUMP_VELOCITY = -200.0
const ATTACK_JUMP_VELOCITY = -100
var last_direction = Vector2.RIGHT


#MECHANICS
var can_dash = true
var casting : bool = false

#HOOKSHOT
var hooking : bool = false

var hook_pos : Vector2
var hooked : bool = false
var rope_length = 50
var current_rope_length


#states
var current_state = null
var prev_state = null

#Nodes
@onready var STATES = $STATES
@onready var Camera = $Camera2D
@onready var Animation_Player = $AnimationPlayer
@onready var Raycasts = $Raycasts

func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
		state.Camera = Camera
		state.Animation_Player = Animation_Player
	current_state = STATES.IDLE
		# INITIALISING REFERENCES IN STATES TO PLAYER
	current_rope_length = rope_length

func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	
	velocity.x = clamp(velocity.x, -200, 500)
	velocity.y = clamp(velocity.y, -200, 200)
	
	move_and_slide()

func gravity(delta):
	if not is_on_floor():
		velocity.y += gravity_value * delta

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func get_next_to_wall():
	for raycast in Raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else: 
				return Vector2.LEFT
	return null

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
	
	#ATTACKS
	if Input.is_action_just_pressed("Attack"):
		attack_input = true
	else:
		attack_input = false
	
	#JUMPS
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else: 
		jump_input = false
	
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
	
	
	#climb
	if Input.is_action_pressed("Climb"):
		climb_input = true
	else: 
		climb_input = false
	
	
	#dash
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else: 
		dash_input = false
	
	#hookshot
	if Input.is_action_just_pressed("Hook"):
		hooking = true
	else:
		hooking = false
		
	#Magic
	if Input.is_action_just_pressed("Magic"):
		casting = true
	else:
		casting = false









func is_dead():
	return false
