extends Node2D

@export var parent : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(parent.chain_velocity)



func hookshot():
	if parent.chains.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		parent.chain_velocity = parent.chains.tip.normalized() * parent.CHAIN_PULL
	else:
		# Not hooked -> no chain velocity
		parent.chain_velocity = Vector2(0,0)
	parent.Player.velocity += parent.chain_velocity
	
	#move_and_slide()	# Actually apply all the forces
	#velocity.x -= walk		# take away the walk speed again
	## ^ This is done so we don't build up walk speed over time
#
	## Manage friction and refresh jump and stuff
	#velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)	# Make sure we are in our limits
	#velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	#var grounded = is_on_floor()
	#if grounded:
		#velocity.x *= FRICTION_GROUND	# Apply friction only on x (we are not moving on y anyway)
		#can_jump = true 				# We refresh our air-jump
		#if velocity.y >= 5:		# Keep the y-velocity small such that
			#velocity.y = 5
	#elif is_on_ceiling() and velocity.y <= -5:	# Same on ceilings
		#velocity.y = -5
	#
	#if !grounded:
		#velocity.x *= FRICTION_AIR
		#if velocity.y > 0:
			#velocity.y *= FRICTION_AIR
