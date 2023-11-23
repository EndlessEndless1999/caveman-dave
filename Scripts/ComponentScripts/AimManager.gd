extends Node2D
class_name AimManager


@export var turn_speed = 100.0
func face_point(point : Vector2, delta):
	var l_point = get_angle_to(point)
	var turn_amount = deg_to_rad(turn_speed * delta)
	
	rotate(-turn_amount * l_point)
	
	#SHOOT FROM THIS NODE
	shoot()


func shoot():
	print('Shooting')
