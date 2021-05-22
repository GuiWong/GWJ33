extends Node

var sounder : Sound_Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connect_to_sounder(s_m : Sound_Player):
	
	sounder = s_m
	
func grab_item():
	
	sounder.grab_item()
	
func drop_item():
	
	sounder.drop_item()
	
func play_coins(x):
	
	sounder.play_coins(x)