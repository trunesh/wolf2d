extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0
# Called when the node ente

func get_push_vector():
	var areas  = get_overlapping_areas()
	var push_vector  = Vector2.ZERO
	if is_colliding():
		var area=areas[0]
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized() #no need to write this 
	return push_vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
