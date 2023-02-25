extends KinematicBody2D

var velocity = Vector2.ZERO

var knockback = Vector2.ZERO
const EnemyDeathEffect = preload("res://src/scenes/effects/EnemyDeathEffect.tscn")
export var ACCELERATION = 300 
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

enum{
	IDLE,
	WANDER,
	CHASE
}
var state = CHASE

onready var sprite = $Sprite
onready var stats=$Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtBox =$HurtBox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	state= pick_random_state([IDLE, WANDER])
	
	 


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION*delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO,FRICTION*delta )
			seek_player()
			if wanderController.get_time_left()==0:
				pick_state_start_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left()==0:
				pick_state_start_wander()
			accelerate_toward_point(wanderController.target_position,delta)
		
			
			if global_position.distance_to(wanderController.target_position)<= WANDER_TARGET_RANGE:
				pick_state_start_wander()
				
		CHASE:
			var player = playerDetectionZone.player
			if player!=null:
				accelerate_toward_point(player.global_position,delta)
			else:
				state = IDLE
	
	if softCollision.is_colliding():
		velocity+= softCollision.get_push_vector()*delta*400
		
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE 

func pick_state_start_wander():
	state = pick_random_state([IDLE,WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func accelerate_toward_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED,ACCELERATION*delta)
	sprite.flip_h= velocity.x <0
	
func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	 

func _on_HurtBox_area_entered(area):
	stats.health-=area.damage
	knockback = area.knockback_vector * 120
	hurtBox.create_hit_effect()
	hurtBox.start_invincibility(0.3)
	pass # Replace with function body.


func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect=EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	 # Replace with function body.


func _on_HurtBox_invincibility_ended():
	animationPlayer.play("stop")


func _on_HurtBox_invincibility_started():
	animationPlayer.play("start")
