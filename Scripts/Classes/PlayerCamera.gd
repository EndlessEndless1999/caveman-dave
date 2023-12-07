extends Camera2D
class_name PlayerCamera

const LOOK_AHEAD_FACTOR = 0.05

var facing = 0
@onready var prev_camera_pos = global_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	prev_camera_pos = global_position

func update_drag_vertical(value : bool):
	#drag_vertical_enabled = value
	pass

