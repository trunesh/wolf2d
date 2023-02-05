extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
const ACCELERATION=500
const MAX_SPEED=80
const FRICTION=500
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
		velocity=velocity.move_toward(input_vector*MAX_SPEED,ACCELERATION*delta) 
	else:
		#velocity=Vector2.ZERO
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	 
	velocity=move_and_slide(velocity)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
