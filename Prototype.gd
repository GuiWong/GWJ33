extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#item_manager.load_item_data()
	progression_manager.load_item_count()
	progression_manager.items_unlocks[0] = true
	progression_manager.items_unlocks[1] = true
	progression_manager.items_unlocks[2] = true
	
	$YSort/Info_Panel.connect_object($YSort/TorchMaker)
	$YSort/Info_Panel.build()
	
	$YSort/Info_Panel2.connect_object($YSort/Potion_Maker)
	$YSort/Info_Panel2.build()
	
	$YSort/Shield_Maker/Info_Panel.connect_object($YSort/Shield_Maker)
	$YSort/Shield_Maker/Info_Panel.build()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
