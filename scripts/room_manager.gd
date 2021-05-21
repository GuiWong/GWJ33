extends Node

var c_room = 0
var c_step 

var comming_content = 0

var path_ended = false

var is_waiting = false

var scroll_speed = 150

var world : Game_World

var room_list = []

signal hero_dead
signal level_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connect_to_world(n_world : Game_World):
	
	world = n_world
	
func set_rooms(liste):
	
	room_list = liste.duplicate(true)

func solve_entry():
	
	
	if comming_content == 0 and world.get_monster().attack_type == 1:
		fight_manager.plan_next_attack(1,true)
		fight_manager.solve_attack(1)
	c_step = 2
	
func solve_item():
	
	if room_list[c_room].content[1] == 0:
		
		world.get_hero().heal(2)
		world.get_hero().update_pv_bar()
		
		
	elif room_list[c_room].content[1] == 1:
		
		world.get_hero().heal(100)
		world.get_hero().update_pv_bar()

	c_step = 3
	world.reset_content()
	
func solve_level_end():
	
	emit_signal("level_ended")
	c_step = 6
	
	path_ended = false
	
			#ET LA HAUT AUSSI APPARAMENT
	#CETAIS LAAAAAAA!!!!!!!!!! (JECROIS)
	world.reset_content()
	
func prepare_fight():
	
	#print('Preparing a fight' + str(world.get_hero().name) +' -- ' + str(world.get_monster().name))
	#fight_manager.load_fighter( world.get_hero(),world.get_monster() )
	fight_manager.start_fight()
	world.start_timer()
	is_waiting = true
	
func end_fight():
	
	
	fight_manager.end_fight()
	if world.get_hero().pv <= 0:
		c_step = 6
		emit_signal('hero_dead')
	else:
		c_step = 3
		
	#OBSOLETE, now handeled by fight manager
	#if world.get_hero().base_pv - world.get_hero().pv >= 4:
		
		#world.get_hero().use_heal()
		#fight_manager.
		#emit_signal('special_used',attacker,1)
		#is_waiting = true
		#running_anim += 1
		
		
	is_waiting = false
	world.stop_timer()
	world.reset_content()
	
func solve_loot():
	
	
	var itm = Monster_Manager.get_loot(room_list[c_room].content[1])
	#print (itm)
	for i in itm:
		world.store_loot(item_manager.create_item(i,1))
		
	world.store_gold_loot(Monster_Manager.get_gold_loot(room_list[c_room].content[1]))
	c_step = 4
	
func solve_wall():
	
	c_step = 5
	
func load_end():
	
	path_ended = true
	
	world.load_content(room_list[c_room].content[0] ,  room_list[c_room].content[1])
	
func go_to_next_room():
	
	#if level_manager.debug:
		#level_manager.current_level += 1
	
	if path_ended:
		#USELESS I THINK
		c_step = 6
		emit_signal('level_ended')
		print('path ended in gtnr')
	else:
		c_step = 0
	c_room += 1
	if len(room_list) <= c_room + 1:
		load_end()
	else:
		
		load_room(room_list[c_room + 1])
	world.current_room_node = ( world.current_room_node + 1 ) % 3
	comming_content = room_list[c_room].content[0]
	if comming_content == 0:
		fight_manager.load_fighter( world.get_hero(),world.get_monster() )
		
	
	
	
func load_room(room):
	
	#print(world.current_room_node)
	#print(' - ' + str(world.current_room_node) + ' - ')
	#print(' - ' + str((world.current_room_node + 1 ) % 3 ) + ' - ')
	#print(' - ' + str((world.current_room_node + 2 ) % 3 ) + ' - ')
	#print(world.get_current_room())
	#print(world.get_next_room())
	#print(world.get_last_room())
	
	var r = world.get_last_room()
	r.position.x = 512
	r.load_room(room)
	#var next = world.get_next_room()
	world.load_content(room_list[c_room].content[0] ,  room_list[c_room].content[1])
	
	
func move_world(delta):
	
	world.move(delta)
	
	
	
func move_is_finished():
	
	if world.get_current_room_pos_x() <= 4:
		
		world.stop()
		return true
	
func solve(delta):
	
	if c_step == 0:
		
		move_world(delta)
		if move_is_finished():
			c_step = 1
			
	elif c_step == 1:
		
		solve_entry()
		
	elif c_step == 2 and not is_waiting:
		
		if comming_content == 0:
		
			prepare_fight()
			
		elif comming_content == 1 or comming_content == 2:
			
			solve_item()
			
		elif comming_content == 3:
			
			solve_level_end()
			
		
	elif c_step == 3 :
		
		solve_loot()
		
	elif c_step == 4:
		
		solve_wall()
		
	elif c_step == 5:
		
		
		go_to_next_room()
		
	elif c_step == 6:
		
		print('path ended in update')
		
	