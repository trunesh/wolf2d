extends Area2D


const HitEffect  = preload("res://src/scenes/effects/HitEffect.tscn")

export(bool) var show_hit=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HurtBox_area_entered(area):
	if show_hit:
		var effect = HitEffect.instance()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position
	pass # Replace with function body.
