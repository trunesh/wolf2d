extends KinematicBody2D

const PlayerHurtSound = preload("res://src/scenes/Player/PlayerHurtSound.tscn")
# Declare member variables here. Examples:
# var a = 2
export var ACCELERATION=500
export var MAX_SPEED=80
export var ROLL_SPEED = 125
export var FRICTION=500

# var b = "text"
enum {
	MOVE,
	ROLL,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitBox = $"HitBoxPivot/Sword-HitBox"
onready var hurtBox = $HurtBox
onready var blinkAnimationPlayer  = $BlinkAnimationPlayer
# Replace with function body.

func _ready():
	randomize()
	stats.connect("no_health",self,"queue_free")
	animationTree.active =true
	swordHitBox.knockback_vector = roll_vector

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
		roll_vector=input_vector
		swordHitBox.knockback_vector = input_vector
		animationTree.set("parameters/idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)
		animationTree.set("parameters/Attack/blend_position",input_vector) 
		animationTree.set("parameters/Roll/blend_position",input_vector)
		animationState.travel("Run")
		velocity=velocity.move_toward(input_vector*MAX_SPEED,ACCELERATION*delta) 
	else:
		#velocity=Vector2.ZERO
		animationState.travel("Idle")
		velocity=velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	 
	velocity=move_and_slide(velocity)
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state=ATTACK
		
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")	
	velocity=move_and_slide(velocity)

func attack_state(_delta):
	animationState.travel("Attack")
	pass	 

func roll_animation_finished():
	state = MOVE

func attack_animation_finished():
	velocity=velocity * 0.9
	state = MOVE
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HurtBox_area_entered(area):
	stats.health-=area.damage
	print("health:----",stats.health) # Replace with function body.
	hurtBox.start_invincibility(0.5)
	hurtBox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	


func _on_HurtBox_invincibility_started():
	blinkAnimationPlayer.play("Start")
	


func _on_HurtBox_invincibility_ended():
	blinkAnimationPlayer.play("stop")
