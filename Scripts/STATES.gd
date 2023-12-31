extends Node

@onready var IDLE = $IDLE
@onready var MOVE = $MOVE
@onready var JUMP = $JUMP
@onready var FALL = $FALL


@onready var DASH = $DASH
@onready var HOOK = $HOOK
@onready var SLIDE = $SLIDE
@onready var MAGIC = $MAGIC
@onready var PARRY = $PARRY

@onready var ATTACK_GROUND = $ATTACK_GROUND
@onready var ATTACK_JUMP = $ATTACK_JUMP
@onready var ATTACK_FALL = $ATTACK_FALL

@onready var HIT = $HURT

@export var hammer_hit_box : HammerHurtBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
