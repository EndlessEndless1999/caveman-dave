extends State
class_name MagicState

var _finished : bool = false

@export var ability : MagicAbility

var cast_dir : Vector2

func enter_state():
	Animation_Player.play("SPELL")
	ability.use(Player)

func update(delta):
	if _finished:
		return STATES.IDLE
	return null

func exit_state():
	_finished = false

func is_finished():
	_finished = true
