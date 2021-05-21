extends Node2D


var chest

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#connect_objects()
	pass

	
func connect_objects():
	
	
	#TODO WHEN NEW: 
	#	ADD COUNT IN update_info_panel
	$YSort/Info_Panel1.connect_object($YSort/TorchMaker)
	$YSort/Info_Panel1.build()
	#info_hooks.append( $YSort/Info_Panel.build() )
	
	$YSort/Info_Panel2.connect_object($YSort/Potion_Maker)
	$YSort/Info_Panel2.build()
	#info_hooks.append($YSort/Info_Panel2.build() )
	
	$YSort/Info_Panel3.connect_object($YSort/Shield_Maker)
	$YSort/Info_Panel3.build()
	
	$YSort/Info_Panel4.connect_object($YSort/Bomb_Maker)
	$YSort/Info_Panel4.build()
	
	$YSort/Info_Panel5.connect_object($YSort/Arrow_Maker)
	$YSort/Info_Panel5.build()
	
	$YSort/Info_Panel6.connect_object($YSort/Sword_Maker)
	$YSort/Info_Panel6.build()
	#info_hooks.append($YSort/Info_Panel3.build() )
	
	chest = $YSort/Chest
	
	#$YSort/Bed.connect('interacted',
	
	
func get_bed():
	
	return $YSort/Bed	

func on_item_unlock(id):
	
	
	update_info_panel(id)
	
	
func update_info_panel(id):
	
	for i in range(6): #TODO: count the number of pannels
		#print("YSort/Info_Panel" + str(i))
		#print (get_node('YSort/Info_Panel')
		var n = get_node("YSort/Info_Panel" + str(i + 1) )
		if id in n.items_hook:
			n.update_sprites(id)

			
func get_hero_path(i):
	return $Hero_path.get_child(i).position
	
func cant_buy():
	
	progression_manager.loose_game()
	
func buy_item(itm):
	
	$Items.add_child(itm)
	
	if not chest.get_item_in_slot(0):
		
		cant_buy() 
		
	elif chest.get_item_in_slot(0).quantity - itm.price < 0:
		
		cant_buy()
		
	else:
		chest.remove_item_count_in_slot(0,itm.price)
	
	place_bough_item(itm)
	
func place_bough_item(itm):
	
	var dx = level_manager.rng.randi_range(2,8) * 8
	var dy = level_manager.rng.randi_range(-3,6) * 8
	itm.position = $Hero_path/s3.position + Vector2(dx,dy)
		
		