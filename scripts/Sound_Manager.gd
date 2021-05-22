extends Node

var sounder : Sound_Player

var music_player

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.stream = load('res://Sounds/Music.ogg')
	music_player.volume_db = -5
	
	
func load_node():
	
	get_tree().root.add_child(music_player)
	play_music()
	
	
func play_music():
	music_player.play()

func connect_to_sounder(s_m : Sound_Player):
	
	sounder = s_m
	
func grab_item():
	
	sounder.grab_item()
	
func drop_item():
	
	sounder.drop_item()
	
func play_coins(x):
	
	sounder.play_coins(x)