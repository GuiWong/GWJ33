extends Node

var items_unlocks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
