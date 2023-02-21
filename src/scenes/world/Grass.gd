extends Node2D


var GrassEffect = preload("res://src/scenes/effects/GrassEffect.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func create_grass_effect():
	var grassEffect=GrassEffect.instance()
	get_parent().add_child(grassEffect) 
	grassEffect.global_position= global_position
	queue_free()


func _on_HurtBox_area_entered(_area):
	create_grass_effect()
	
	pass # Replace with function body.
