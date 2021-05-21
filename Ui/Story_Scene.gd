extends Control

# Declare member variables here. Examples:
var can_leave = false
var timer

func is_ready():
	
	can_leave = true

	
func _ready():
	timer = Timer.new()
	timer.wait_time = 0.1
	
	add_child(timer)
	timer.connect('timeout',self,'is_ready')
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if can_leave and Input.is_action_just_pressed('a'):
		
		get_tree().change_scene('res://Game_Scenes/Game.tscn')
		
	if can_leave and Input.is_action_just_pressed('b'):
		
		get_tree().change_scene('res://Game_Scenes/Game.tscn')

