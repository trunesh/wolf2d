extends KinematicBody2D

var knockback = Vector2.ZERO

onready var stats=$Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)

func _on_HurtBox_area_entered(area):
	stats.health-=area.damage
	knockback = area.knockback_vector * 120
	pass # Replace with function body.


func _on_Stats_no_health():
	queue_free()
	 # Replace with function body.
