extends Node2D
class_name Game_World

class Room:
	var ground
	var back
	var content
	var wall
	func _init(g,b,c,w):
		ground = g
		back = b
		content = c
		wall = w
		
var current_room_node = 0

#temporary!!
var romlist = []

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
	
	romlist.append( Room.new(0,0,[0,0],0) )
	gen_lot_of_room(6)
	
	room_manager.connect_to_world(self)
	room_manager.set_rooms(romlist)
	
	$Rooms/Room.load_room(romlist[0])
	
	room_manager.go_to_next_room()
	
	$Timer.connect('timeout',fight_manager,'fight_tick')
	fight_manager.connect('fight_end',room_manager,'end_fight')
	
func _process(delta):
	
	room_manager.solve(delta)

func gen_lot_of_room(i):
	#var romlist = []
	for a in range(i):
		romlist.append(Room.new(1,1,[0,a % 2],0))
	return romlist
	
	
func get_hero():
	return $Hero.get_child(0)
func get_monster():
	return $Monsters.get_child(0)
	

	
func load_content( monster_data , monster_id = 0):
	#LOT TODO
	
	$Monsters.get_child(0).position = get_next_room().position + get_current_room().get_monster_pos()
	
	$Monsters.get_child(0).pv = monster_data[0]
	$Monsters.get_child(0).attack = monster_data[1]
	$Monsters.get_child(0).attack_type = monster_data[2]
	$Monsters.get_child(0).attack_time = monster_data[3]
	var rect = Monster_Manager.get_monster_rect_pos(monster_id)
	$Monsters.get_child(0).set_texture_rect(rect[0],rect[1])
	$Monsters.get_child(0).update_pv_bar()
	
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