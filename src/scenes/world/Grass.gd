extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var GrassEffect = load("res://src/scenes/effects/GrassEffect.tscn")
		var grassEffect=GrassEffect.instance()
		var world  = get_tree().current_scene
		world.add_child(grassEffect) 
		grassEffect.global_position= global_position
		queue_free()


func _on_HurtBox_area_entered(area):
	pass # Replace with function body.
