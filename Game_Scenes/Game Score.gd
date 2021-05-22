extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Data/Days.text = str(day_manager.current_day)
	$Data/Money.text = str(progression_manager.total_coin_earned)
	
	if level_manager.current_level == level_manager.last_level:
		
		$Win.visible = true
		$Loose.visible = false
		
	else:
		
		$Loose.visible = true
		$Win.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("a"):
	
		get_tree().change_scene('res://Game_Scenes/Credits.tscn')
