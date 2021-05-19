extends Node

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
		
var rng 
var current_level = 1

var debug = false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = 123
	
	
func go_to_next_level():
	
	current_level += 1
	
	
func gen_level_n():
	
	if debug:
		
		return gen_level_test()
	
	if current_level == 1:
		
		return gen_level_1()
		
	elif current_level ==2:
		
		return gen_level_2()
		
	


func gen_content_from_pool(pool : Array):
	
	var n = rng.randi_range(0,len(pool)-1)
	return pool[n].duplicate()
	
func gen_shop_room():
	
	return(Room.new(0,0,[0,0],0))
	
func gen_from_pool(q,g_id,w_id,content_list):
	
	var dat = []
	
	for i in range(q):
		
		var rom = Room.new(g_id,w_id,gen_content_from_pool(content_list),0)
		dat.append(rom)
		
	return dat
func gen_level_1():
	
	var level = []
	
	level.append(gen_shop_room())
	
	var bl = gen_from_pool(6,1,1, [ [0,0] , [0,1] ] )
	
	for e in bl:
		
		level.append(e)
		
	
		
	var bl2 = gen_from_pool(3,2,2, [ [0,1] , [0,2] ] )
	
	for e2 in bl2:
		
		level.append(e2)
		
	level.append(Room.new(2,2,[1,1],0))
	
	var bl3 = gen_from_pool(2,2,2, [ [0,1] , [0,2] ] )
	
	
	for e3 in bl3:
		
		level.append(e3)
		
	level.append(Room.new(2,2,[3,0],0))
		
	#print level
	return level
	
	
func gen_level_2():
	
	var level = []
	
	level.append(gen_shop_room())
	
	var pack = gen_from_pool(3,1,1,[ [0,0] , [0,1] ])
	
	for r in pack:
		
		level.append(r)
		
	pack = gen_from_pool(6,3,3,[ [0,2],[0,3] ])
	
	for r in pack:
		
		level.append(r)
		
	level.append(Room.new(3,4,[3,0],0))
	
	
	return level
	
	
func gen_level_test():
	
	var level = []
	
	level.append(gen_shop_room())
	level.append(Room.new(3,3,[0,0],0))
	#level.append(Room.new(3,3,[0,0],0))
	#level.append(Room.new(3,3,[0,2],0))
	level.append(Room.new(3,3,[0,2],0))
	
	level.append(Room.new(3,3,[1,1],0))
	
	level.append(Room.new(2,2,[0,3],0))
	level.append(Room.new(2,2,[0,3],0))
	
	level.append(Room.new(1,1,[3,0],0))
	
	return level
		
		