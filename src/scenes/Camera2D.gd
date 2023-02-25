extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomright = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomright.position.y
	limit_right = bottomright.position.x

