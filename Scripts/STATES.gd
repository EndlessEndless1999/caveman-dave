extends Node

@onready var IDLE = $IDLE
@onready var MOVE = $MOVE
@onready var JUMP = $JUMP
@onready var FALL = $FALL
@onready var DASH = $DASH
@onready var SLIDE = $SLIDE

@onready var ATTACK_GROUND = $ATTACK_GROUND
@onready var ATTACK_JUMP = $ATTACK_JUMP
@onready var ATTACK_FALL = $ATTACK_FALL

@export var hammer_hit_box : HammerHurtBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
