extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	
	#item_manager.load_item_data()
	progression_manager.load_item_count()
	progression_manager.items_unlocks[0] = true
	progression_manager.items_unlocks[1] = true
	progression_manager.items_unlocks[2] = true
	
	progression_manager.connect("unlocked",self,'on_item_unlock')
	
	$YSort/Info_Panel1.connect_object($YSort/TorchMaker)
	$YSort/Info_Panel1.build()
	#info_hooks.append( $YSort/Info_Panel.build() )
	
	$YSort/Info_Panel2.connect_object($YSort/Potion_Maker)
	$YSort/Info_Panel2.build()
	#info_hooks.append($YSort/Info_Panel2.build() )
	
	$YSort/Info_Panel3.connect_object($YSort/Shield_Maker)
	$YSort/Info_Panel3.build()
	#info_hooks.append($YSort/Info_Panel3.build() )
	
	
func on_item_unlock(id):
	
	update_info_panel(id)
	
	
func update_info_panel(id):
	
	for i in range(3): #TODO: count the number of pannels
		print("YSort/Info_Panel" + str(i))
		#print (get_node('YSort/Info_Panel')
		var n = get_node("YSort/Info_Panel" + str(i + 1) )
		if id in n.items_hook:
			n.update_sprites(id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
