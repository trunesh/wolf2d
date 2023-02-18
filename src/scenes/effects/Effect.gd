extends AnimatedSprite



func _ready():
	self.connect("animation_finished",self,"_on_animation_finished")
	
	play("Animate")
	 # Replace with function body.



func _on_animation_finished():
	queue_free()
