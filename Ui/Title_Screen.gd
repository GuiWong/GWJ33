extends Control


var can_change = false
var timer

# Called when the node enters the scene tree for the first time.

func is_ready():
	
	can_change = true
	
func _ready():
	timer = Timer.new()
	timer.wait_time = 0.2
	
	add_child(timer)
	timer.connect('timeout',self,'is_ready')
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed('a') and can_change:
		
		if name == 'Title_Screen' :#and can_change:
			
			get_tree().change_scene('res://Ui/How_To_play.tscn')
		
		elif name == 'How_To_play':
			
			get_tree().change_scene('res://Game_Scenes/Story_Scene.tscn')
			
		else:
			
			get_tree().change_scene('res://Game_Scenes/Game.tscn')
			
	if Input.is_action_just_pressed("ui_cancel"):
		
		progression_manager.exit_game()
			
		
		
#func _input(event):
	
	#print(event.ty)
	#print (event.as_text())
#	if event.is_action_type() and can_change: #
		
		
