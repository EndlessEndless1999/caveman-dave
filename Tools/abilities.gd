extends Sprite2D

@export var ability : Panel
@export var label : RichTextLabel
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("dash", on_dash)
	Game.connect("shell", on_shell)
	Game.connect("hook", on_hook)
	frame = Game.frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame = Game.frame

func on_dash():
	frame = 3
	Game.frame = 3
	timer.start()
	ability.show()
	

func on_shell():
	frame = 2
	Game.frame = 2
	timer.start()
	label.text = 'You got the shell! Press R to parry.'
	ability.show()

func on_hook():
	frame = 0
	Game.frame = 0
	timer.start()
	label.text = 'You got the hookshot! Press Shift to Hook'
	ability.show()

func _on_timer_timeout():
	ability.hide()
