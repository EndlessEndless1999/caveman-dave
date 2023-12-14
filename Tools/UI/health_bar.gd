extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.health_changed.connect(on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func on_health_changed(health):
	while value < health:
		value += 1
