extends Node

var items_unlocks = []
signal unlocked(id)
var exiting = false

var paused = false

var total_coin_earned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func load_item_count():
	var c = item_manager.get_item_count()
	for i in range(c):
		items_unlocks.append(false)
		
func get_item_sprite(id):
	
	if items_unlocks[id]:
		return item_manager.get_item_sprite(id)
	else:
		#return Vector2(0,0)
		return Vector2(112,112)
		
func discover(id):
	
	#print (str(id) + ' unlocked!')
	if items_unlocks[id]:
		pass
		
	else:
		items_unlocks[id] = true
		emit_signal("unlocked",id)
		
		
func finish_game():
	
	#if OS.has_feature('Alpha_Build'):
		#get_tree().change_scene('res://Game_Scenes/Game_Finished.tscn')
	#else:
	get_tree().change_scene('res://Game_Scenes/Game_Finished.tscn')
	
func loose_game():
	
	get_tree().change_scene('res://Game_Scenes/Game_Over.tscn')
	
func exit_game():
	
	
	exiting = true
	get_tree().change_scene('res://Game_Scenes/Credits.tscn')
	
	exiting = true
	
func pause(value):
	
	var scene = get_tree().get_current_scene()
	if scene.name == 'Game':
		get_tree().paused = value
		scene.toggle_pause_visible()
	
#func play():
	
#	get_tree().root

	
#Very Temporyry !!!	
func _process(delta):
	#if Input.is_action_just_pressed("ui_accept"):
	#	finish_game()
		
	if Input.is_action_just_pressed("ui_cancel"):
		paused = not paused
		
		pause(paused)
