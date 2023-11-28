extends ActorState

@export var bullet = preload("res://Scenes/Components/projectile.tscn") 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enter_state():
	Actor.velocity = Vector2.ZERO
	Actor.stopped = true
	spawn_projectile()

func exit_state():
	Actor.stopped = false


func update(delta):
	if Actor.shooting == false:
		return STATES.PATROL
		
	Actor.move_and_slide()
	return null


func spawn_projectile():
	if bullet:
		var scene = bullet.instantiate()
		get_tree().current_scene.add_child(scene)
		scene.global_position = Actor.global_position
		scene.global_rotation = Actor.raycast.global_rotation
	
	
	
	
	await get_tree().create_timer(2).timeout
	Actor.shooting = false
