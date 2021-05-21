extends Control

var splash_scene = ['res://Ui/Splash/Godot.tscn',
					'res://Ui/Splash/Jam.tscn',
					'res://Ui/Splash/Wong.tscn']
export(int) var current
const splash_screens_count = 3

func _ready():
	pass # Replace with function body.

func skip():
	
	if current + 1 == splash_screens_count:
		
		get_tree().change_scene('res://Game_Scenes/Title_Screen.tscn')
		
	else:
		
		get_tree().change_scene(splash_scene[current + 1])
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("a"):
		skip()
	if Input.is_action_just_pressed("b"):
		skip()