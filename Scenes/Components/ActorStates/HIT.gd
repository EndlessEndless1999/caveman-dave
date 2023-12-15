extends ActorState
class_name Hit

var knockback_velocity = Vector2(100, 0)

var _ready : bool = false

func enter_state():
	Animation_Player.play("HIT")
	Actor.health -= 10
	
	if Actor.health <= 0:
		Actor.queue_free()

func exit_state():
	_ready = false
	Actor.hit = false

func update(delta):
	Actor.velocity = knockback_velocity
	
	if _ready:
		return STATES.PATROL
	
	return null



func is_ready():
	_ready = true

