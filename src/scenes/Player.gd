extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
const ACCELERATION=10
const MAX_SPEED=100
const FRICTION=10
# var b = "text"
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():   
	pass # Replace with function body.

func _physics_process(delta):
	var input_vector  = Vector2.ZERO
	input_vector.x=Input.get_action_strength("rightD") -Input.get_action_strength("leftA")
	input_vector.y=Input.get_action_strength("DownS") - Input.get_action_strength("UpW")
	input_vector=input_vector.normalized()
	
	
	if input_vector!=Vector2.ZERO:
		velocity+=input_vector * ACCELERATION * delta
		velocity= velocity.clamped(MAX_SPEED * delta)
	else:
		#velocity=Vector2.ZERO
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	
	move_and_collide(velocity)
	"""
	if Input.is_action_pressed("UpW"):
		#position.y-=1
		velocity.y-=1
	elif Input.is_action_pressed("DownS"):
		#osition.y+=1
		velocity.y+=1
	elif Input.is_action_pressed("leftA"):
		#position.x-=1
		velocity.x-=1
	elif Input.is_action_pressed("rightD"):
		#position.x+=1
		velocity.x+=1
	else:
		velocity.x=0
		velocity.y=0
	move_and_collide(velocity)
	"""
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
