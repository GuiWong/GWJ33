extends Control

# Declare member variables here. Examples:
# var a = 2
var step = 0
var can_change = false
var timer

# Called when the node enters the scene tree for the first time.

func is_ready():
	
	can_change = true
	
func _ready():
	timer = Timer.new()
	timer.wait_time = 1
	
	add_child(timer)
	timer.connect('timeout',self,'is_ready')
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	#if Input.is_action_just_pressed('a'):
	#	get_tree().change_scene('res://Ui/How_To_play.tscn')
		
func _input(event):
	
	#print(event.ty)
	#print (event.as_text())
	if event.is_action_type() and can_change: #
		
		if name == 'Title_Screen' :#and can_change:
			
			get_tree().change_scene('res://Ui/How_To_play.tscn')
		
		elif name == 'How_To_play':
			
			get_tree().change_scene('res://Game_Scenes/Story_Scene.tscn')
			
		else:
			
			get_tree().change_scene('res://Game_Scenes/Game.tscn')
