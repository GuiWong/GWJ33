extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if Input.is_action_just_pressed("a"):
	
		get_tree().change_scene('res://Game_Scenes/Game Score.tscn')
