extends Node2D
class_name Object_Class

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func get_class(): 
	return "Object_class"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_texture_rect(x,y):
	
	$Sprite.region_rect.x = x
	$Sprite.region_rect.y = y