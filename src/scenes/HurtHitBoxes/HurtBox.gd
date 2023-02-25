extends Area2D


const HitEffect  = preload("res://src/scenes/effects/HitEffect.tscn")

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer  = $Timer
onready var collisionShape = $CollisionShape2D



func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
#export(bool) var show_hit=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_invincibility(duration):
		self.invincible = true
		timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position
	


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_started():
	collisionShape.set_deferred("disabled",true)
	#monitorable = false

func _on_HurtBox_invincibility_ended():
	collisionShape.disabled	 = false
	#monitoring = true

