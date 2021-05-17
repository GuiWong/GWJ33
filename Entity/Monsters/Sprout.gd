extends Fighter
class_name Sprout

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func change_color():
	
	$PvBar.modulate = Color(0,0,0)