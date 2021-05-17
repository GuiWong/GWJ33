extends Node

var c_room = 0
var c_step 

var path_ended = false

var is_waiting = false

var scroll_speed = 100

var world

var room_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connect_to_world(n_world : Game_World):
	
	world = n_world
	
func set_rooms(liste):
	
	room_list = liste.duplicate(true)

func solve_entry():
	
	c_step = 2
	
func prepare_fight():
	
	print('Preparing a fight' + str(world.get_hero().name) +' -- ' + str(world.get_monster().name))
	#fight_manager.load_fighter( world.get_hero(),world.get_monster() )
	fight_manager.start_fight()
	world.start_timer()
	is_waiting = true
	
func end_fight():
	
	if world.get_hero().pv <= 0:
		c_step = 6
	else:
		c_step = 3
	is_waiting = false
	world.stop_timer()
	
func solve_loot():
	
	c_step = 4
	
func solve_wall():
	
	c_step = 5
	
func load_end():
	
	path_ended = true
	
func go_to_next_room():
	
	
	if path_ended:
		c_step = 6
	else:
		c_step = 0
	c_room += 1
	if len(room_list) <= c_room + 1:
		load_end()
	else:
		load_room(room_list[c_room + 1])
	world.current_room_node = ( world.current_room_node + 1 ) % 3
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
	world.load_content( Monster_Manager.get_monster_data(room_list[c_room].content[1]) , room_list[c_room].content[1])
	
	
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
		
		prepare_fight()
		
	elif c_step == 3 :
		
		solve_loot()
		
	elif c_step == 4:
		
		solve_wall()
		
	elif c_step == 5:
		
		go_to_next_room()
		
	