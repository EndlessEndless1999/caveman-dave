extends State
class_name MagicState


@export var ability : MagicAbility

var cast_dir : Vector2

func enter_state():
	ability.use(Player)

func update(delta):
	return STATES.IDLE

func exit_state():
	pass
