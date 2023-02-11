extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
const ACCELERATION=500
const MAX_SPEED=80
const FRICTION=500
# var b = "text"
enum {
	MOVE,
	ROLL,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
# Replace with function body.

func _ready():
	animationTree.active =true
	

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ATTACK:
			attack_state(delta)
			
		ROLL:
			roll_state(delta)	

func move_state(delta):
	var input_vector  = Vector2.ZERO
	input_vector.x=Input.get_action_strength("rightD") -Input.get_action_strength("leftA")
	input_vector.y=Input.get_action_strength("DownS") - Input.get_action_strength("UpW")
	input_vector=input_vector.normalized()
	
	
	if input_vector!=Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)
		animationTree.set("parameters/Attack/blend_position",input_vector) 
		animationState.travel("Run")
		velocity=velocity.move_toward(input_vector*MAX_SPEED,ACCELERATION*delta) 
	else:
		#velocity=Vector2.ZERO
		animationState.travel("Idle")
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	 
	velocity=move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state=ATTACK
		
func roll_state(delta):
	pass

func attack_state(delta):
	animationState.travel("Attack")
	pass	 


func attack_animation_finished():
	velocity=Vector2.ZERO
	state = MOVE
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
