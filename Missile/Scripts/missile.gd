extends RigidBody2D

var _direction := Vector2.ZERO
var _acceleration := Vector2.ZERO
var _drag := Vector2.ZERO
var _targetvector := Vector2.ZERO

var _thrust := 0
var _aggression := 1000

@export var target : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _physics_process(delta:float):
	#Take the direction
	_direction = Vector2(cos(rotation), sin(rotation))
	_find_target_trajectory()
	#The missile goes where it's pointed
	_acceleration = 1000 * Vector2(cos(rotation), sin(rotation))
	#The missile hits a terminal velocity
	_drag = (-(_direction) * 0.5 * linear_velocity)
	#The prepared forces are applied
	apply_force((_acceleration + _drag))
	apply_torque(_thrust * _aggression)

func _find_target_trajectory():
	_targetvector = target.position - position 
	if _targetvector.angle() >= 0:
		_thrust = 1
	else: 
		_thrust = -1
		
	
#Next step: use math to slow the torque as the angles draw near
