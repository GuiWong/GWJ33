extends Node2D
class_name Game_World


var current_room_node = 0

var monster_nodes = [null,null,null]

#temporary!!
#var romlist = []

func get_next_room():
	
	return $Rooms.get_child( (current_room_node + 1 ) % 3)
	
func get_current_room():
	
	return $Rooms.get_child(current_room_node)
	
func get_current_room_pos_x():
	
	return get_current_room().position.x
	
func get_last_room():
	
	return $Rooms.get_child( (current_room_node + 2 ) % 3)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#romlist.append( level_manager.Room.new(0,0,[0,0],0) )
	#gen_lot_of_room(6)
	
	#var romlist = level_manager.gen_level_1()
	
	#room_manager.connect_to_world(self)
	#room_manager.set_rooms(romlist)
	
	#instance_content()
	
	
	
	pass
	
func initiate_world():
	
	
	room_manager.connect_to_world(self)
	
	get_next_room().load_room(room_manager.room_list[1])
		
	instance_content()
	room_manager.go_to_next_room()
	$Timer.connect('timeout',fight_manager,'fight_tick')
	fight_manager.connect('fight_end',room_manager,'end_fight')
	
func _process(delta):
	
	room_manager.solve(delta)
	
func instance_content():
	
	for r in room_manager.room_list:
		
		if r.content[0] == 0: #monster case
		
			if not monster_nodes[r.content[1]]:
				
				var monstr = Monster_Manager.create_monster_node(r.content[1])
				monster_nodes[r.content[1]] = monstr
				#$Hidden_Instances.add_child(monstr)
				
func reset_content():
	
	$Monsters.remove_child($Monsters.get_child(0))
				
		
func get_monster_node(id):
	
	return monster_nodes[id]

func gen_lot_of_room(i):
	#var romlist = []
	#for a in range(i):
	#	romlist.append(level_manager.Room.new(1,1,[0,a % 2],0))
	#return romlist
	
	pass
	
	
	
func get_hero():
	return $Hero.get_child(0)
func get_monster():
	return $Monsters.get_child(0)
	
func get_bag_content():
	
	return $Bag/Content
	

func store_loot(item):
	
	$Bag.add_item(item)
	print('item stored')
	
func store_gold_loot(q):
	
	$Bag.add_gold(q)
	
func load_content(content_type ,  monster_id = 0):
	#LOT TODO
	
	if content_type == 0:
	
		$Monsters.add_child(get_monster_node(monster_id))
	
		$Monsters.get_child(0).reset()
		
		$Monsters.get_child(0).position = get_next_room().position + get_current_room().get_monster_pos()
	
	elif content_type == 1:
		
		$Monsters.add_child(item_manager.create_item(0,5))
		
	else:
		
		pass
	#$Monsters.get_child(0).pv = monster_data[0]
	#$Monsters.get_child(0).attack = monster_data[1]
	#$Monsters.get_child(0).attack_type = monster_data[2]
	#$Monsters.get_child(0).attack_time = monster_data[3]
	#var rect = Monster_Manager.get_monster_rect_pos(monster_id)
	#$Monsters.get_child(0).set_texture_rect(rect[0],rect[1])
	#$Monsters.get_child(0).update_pv_bar()
	
	
	
func start_timer(n=null):
	if n != null:
		$Timer.wait_time = n
	$Timer.start()
	
func stop_timer():
	$Timer.stop()
	
func stop():
	get_current_room().position.x = 0
	get_next_room().position.x = 256
	get_last_room().position.x = -256
	
func move(delta):
	
	$Rooms/Room.position.x -= room_manager.scroll_speed * delta
	$Rooms/Room2.position.x -= room_manager.scroll_speed * delta
	$Rooms/Room3.position.x -= room_manager.scroll_speed * delta
	$Monsters.get_child(0).position.x -= room_manager.scroll_speed * delta