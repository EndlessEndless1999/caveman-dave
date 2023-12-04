extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0.0,0.5)
	tween.set_trans(Tween.TRANS_QUART) 
	tween.set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
