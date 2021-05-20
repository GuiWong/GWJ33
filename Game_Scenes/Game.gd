extends Node2D

var hero
var is_processing_hero = false
var hero_step = 0
var sold_done = false

var just_arrived = false




func _ready():
	
	#item_manager.load_item_data()
	progression_manager.load_item_count()
	progression_manager.items_unlocks[0] = true
	progression_manager.items_unlocks[1] = true
	progression_manager.items_unlocks[2] = true
	
	progression_manager.connect("unlocked",self,'on_item_unlock')
	room_manager.connect("hero_dead",self,'on_hero_die')
	room_manager.connect('level_ended',self,'on_hero_win')
	
	$Shop.connect_objects()
	
	$Shop.get_bed().connect('interacted',self,'try_sleep')
	
	
	instanciate_things()
	
	
	print(fight_manager.connect('special_used',$World,'play_special_anim'))
	print($World/Fight_Animator/Hero_Anims.connect("animation_finished",fight_manager,'animation_waiter'))
	
	
	
	$World.store_loot(item_manager.create_item(0,1))
	$World.store_loot(item_manager.create_item(0,1))
	$World.store_loot(item_manager.create_item(1,1))
	$Timer.connect("timeout",self,'sell_loop')
	
	
	#May be bad, already have signal hero win
	#level_manager.connect('next_level',self,'on_next_level')
	
	
	day_manager.connect('dawn_start',self,'on_dawn')
	day_manager.connect('morning_start',self,'on_morning')
	day_manager.connect('day_start',self,'on_day')
	day_manager.connect('evening_start',self,'on_evening')
	
	day_manager.start_dawn()
	
	
	$Shop.chest.add_item(item_manager.create_item(7,30))

func on_dawn():
	
	$Dawn_Scene.visible = true
	$Dawn_Scene.set_process(true)
	$Dawn_Scene/Label2.text = str(day_manager.current_day)
	room_manager.set_rooms(level_manager.gen_level_n())
	room_manager.c_room = 0
	$Shop/YSort/Player.position = Vector2(400,464)
	
	$Shop/YSort/Player.set_process(false)
	
	$World/Game_Over_World.visible = false
	$World/Level_ended.visible = false
	$World/Level_ended/Label2.text = str(level_manager.current_level)
	
	hero.reset()
	hero.apply_equipement()
	hero_step = 0
	sold_done = false
	
func on_morning():
	
	
	$World.get_next_room().load_room(room_manager.room_list[1])
	
	$World.get_current_room().load_room(room_manager.room_list[0])
	
	
	$Dawn_Scene.visible = false
	$Dawn_Scene.set_process(false)
	place_hero_in_shop()
	is_processing_hero = true
	
	$Shop/YSort/Player.set_process(true)
	
	
func on_day():
	
	launch_adventure()
	
func on_evening():
	
	#$World/Game_Over_World.visible = true
	
	$World.processing_rooms = false
	
func on_hero_die():
	
	$World/Bag.empty_consumables()
	$World/Game_Over_World.visible = true
	day_manager.start_evening()
	
func on_hero_win():
	
	$World/Level_ended.visible = true
	day_manager.start_evening()
	level_manager.go_to_next_level()
	
	#TODO Do that better
	
	hero.base_pv = 6 + 2 * (level_manager.current_level - 1)
	
	
func on_item_unlock(id):
	
	
	$Shop.on_item_unlock(id)
	
func try_sleep():
	
	if day_manager.has_day_passed():
		
		day_manager.start_sleep()
		
		
func instanciate_things():
	
	hero = load('res://Entity/Hero.tscn').instance()
	hero.connect('charge_used',self,'update_bag_fom_charges')
		
		
func update_bag_fom_charges(i,ql):
	
	$World/Bag.update_consumables(i,ql)
	
func take_hero():
	
	if hero.get_parent():
		
		hero.get_parent().remove_child(hero)
		
func place_hero_in_shop():
	
	take_hero()
	$Shop.add_child(hero)
	hero.position=$Shop.get_hero_path(0)
	
func place_hero_in_world():
	
	take_hero()
	$World/Hero.add_child(hero)
	hero.position = Vector2(96,96)
	
func _process(delta):
	
	if is_processing_hero:
		
		if hero.go_to_point($Shop.get_hero_path(hero_step),delta):
			hero_step += 1
			just_arrived = true
			
			
		if hero_step == 3 and not sold_done:
			
			print ('starting sell')
			is_processing_hero = false
			$Timer.start()
			
		if hero_step in [4,5,6,7] and just_arrived:
			
			buy_item(hero_step-3)
			just_arrived = false
			
			
		if hero_step > 8:
			is_processing_hero = false
			#launch_adventure() #TODO: Use day manager for that
			day_manager.start_day()
			
func resume_hero_path():
	
	is_processing_hero = true
	print('restarting hero pathing')
	
func load_hero_charges_from_bag():
	
	hero.heal_charges = $World/Bag.potion
	
	hero.charges[0] = $World/Bag.arrow
	
	hero.charges[1] = $World/Bag.bomb
	
	
	
func launch_adventure():
	
	place_hero_in_world()
	load_hero_charges_from_bag()
	#room_manager.set_rooms(level_manager.gen_level_1())
	$World.initiate_world()
	$World.processing_rooms = true
	
	
func get_next_bag_item():
	
	if $World.get_bag_content().get_child_count() >=1:
		var itm = $World.get_bag_content().get_child($World.get_bag_content().get_child_count()-1)
		$World.get_bag_content().remove_child(itm)
		return itm
		$World/Bag.total -= 1
	else:
		return false
		
		
		
func can_buy(id,price):
	
	var ret = 0
	
	if price > $World/Bag.gold:
		
		return ret
		
	if id in global.consumables:
		
		if $World/Bag.has_space_for(id):
			
			ret = 1
		
	elif id in global.upgrades:
		
		if hero.can_equip(id):
			
			ret = 2
		
	return ret
func buy_item(i):
	
	var shelf = get_node('Shop/YSort/Shelf' + str(i))
	
	if not shelf.get_item_in_slot(0):
		
		return false
	
	var item_id = shelf.get_item_in_slot(0).id
	var price = shelf.get_item_in_slot(0).price * shelf.get_item_in_slot(0).quantity
	
	
	if can_buy(item_id,price) == 1:
		
		$World/Bag.store_consumable(item_id,shelf.get_item_in_slot(0).quantity)
		$World/Bag.remove_gold(price)
		$Shop.chest.add_money(price)
		shelf.remove_item_in_slot(0)
		shelf.delete_price()
		
	elif can_buy(item_id,price) == 2:
		
		hero.equip_item(item_id)
		$World/Bag.remove_gold(price)
		$Shop.chest.add_money(price)
		shelf.remove_item_in_slot(0)
		
		hero.apply_equipement()
		
		
	
func sell_loop():
	
	var i = get_next_bag_item()
	if i:
		$Shop.buy_item(i)
		$World/Bag.add_gold(i.price)
		$World/Bag.total -= 1
	else:
		$Timer.stop()
		resume_hero_path()
		sold_done = true
		
		print( 'sold everything')
		
		
	