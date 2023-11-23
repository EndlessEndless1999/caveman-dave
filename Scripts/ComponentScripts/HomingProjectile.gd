extends Node2D
class_name HomingProjectile

var target : Player
var move_speed = 0.0
var projectile : CharacterBody2D


func setup(_target, _move_speed):
	#This is called inside of enemy when it spawns the projectile
	target = _target
	move_speed = _move_speed

func _physics_process(delta):
	var move_direction = global_position - target.global_position
	projectile.velocity = move_direction * projectile.speed * delta
	
	projectile.move_and_slide()
	#Create random timer that selects all but one missile and makes sure they lose target. Otherwise all three will go.
	
	#on timeout run a function to disable target lock on


