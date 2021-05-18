extends Object_Class
class_name Interactable
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal interacted

func get_class():
	
	return 'Interactable'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_interaction(item):
	emit_signal("interacted")
	return item
