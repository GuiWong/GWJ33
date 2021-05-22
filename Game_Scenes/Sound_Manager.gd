extends Node2D
class_name Sound_Player
# Declare member variables here. Examples:
# var a = 2
var coin_sound = 'res://Sounds/coin1.wav'
var current_coin_sound = 0
var coin_queue_count = 0
var coin_queue_max = 0

var coin_chain_queued = []


var base_coin_volume = -20
var coin_volume_var = 10


func get_volume():
	
	return base_coin_volume - coin_volume_var * ( (coin_queue_max - (coin_queue_count + 1) ) / max(0.1,coin_queue_max)  )
	

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5):
		var coin = AudioStreamPlayer.new()
		coin.stream = load(coin_sound)
		coin.volume_db = -10
		coin.name = 'coin' + str(i)
		$Coins.add_child(coin)

func grab_item():
	$Node/item_grab.play()
	
func drop_item():
	$Node/item_drop.play()
	
func get_coin_player(i):
	
	return $Coins.get_child(i)
	
func play_next_coin():
	
	coin_queue_count -= 1
	current_coin_sound = ( current_coin_sound + 1 ) % 5
	get_coin_player(current_coin_sound).volume_db = get_volume()
	get_coin_player(current_coin_sound).play()
	if coin_queue_count >= 1:
		$Coin_Ticker.start()
	elif len(coin_chain_queued) >= 1:
		play_coins(coin_chain_queued[0])
		coin_chain_queued.remove(0)
	else:
		coin_queue_max = 0

func play_coins(x):
	
	if coin_queue_max > 0:
		coin_chain_queued.append(x)
	else:
		coin_queue_count = x
		coin_queue_max = x
	
		play_next_coin()
