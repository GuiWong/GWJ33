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
var last_level = 8

#signal next_level

var debug = false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	rng.seed = 123
	
	
func get_level_color(i = null):
	
	if i == null:
		i = current_level
	
	if i == 1:# or i == 0:
		
		return Color(0.286275, 0.243137, 0.694118)
		
	elif i == 2:
		
		return Color(0.172549, 0.627451, 0.898039)
		
	elif i == 3 or i == 4:
		
		return Color(0.85098, 0.694118, 0.078431)
		
	elif i == 5:
		
		return Color(0.937755, 0.964844, 0.097992)
		
	elif i == 6:
		
		return Color(0.132812, 0.132812, 0.132812)
		
	elif i == 7:
		
		return Color(0.882353, 0, 0)
		
	else:
		
		return Color(1,1,1)
	
func has_finished_game():
	
	
	return current_level == last_level
	
func go_to_next_level():
	
	current_level += 1
	
	#emit_signal("next_level")
	
func gen_level_n():
	
	if debug:
		
		#return gen_level_7()
		pass
	
	if current_level == 1:
		
		return gen_level_1()
		
	elif current_level ==2:
		
		return gen_level_2()
		
	elif current_level == 3:
		
		return gen_level_3()
		
	elif current_level == 4:
		
		return gen_level_4()
		
	elif current_level == 5:
		
		return gen_level_5()
		
	elif current_level == 6:
		
		return gen_level_6()
		
	elif current_level == 7:
		
		return gen_level_7()
	
		
	else:
		
		return gen_level_test()
	


func gen_content_from_pool(pool : Array):
	
	var n = rng.randi_range(0,len(pool)-1)
	return pool[n].duplicate()
	
func gen_shop_room():
	
	return(Room.new(0,0,[0,0],0))
	
func gen_content_list_from_pool(q,pool):
	
	var dat = []
	
	for i in range(q):
		
		var rom = gen_content_from_pool(pool)
		dat.append(rom.duplicate())
		
	return dat
	
func gen_from_list(g_id,w_id,content_list : Array):
	
	var pool = content_list#.duplicate()
	var i
	var result = []
	
	while len(pool) >= 1:
		
		i = rng.randi_range(0 , len(pool) - 1 )
		#print (pool[i])
		result.append(Room.new(g_id,w_id,pool[i].duplicate() , 0 ))
		pool.remove(i)
		
	return result
	
func gen_from_pool(q,g_id,w_id,content_list):
	
	var dat = []
	
	for i in range(q):
		
		var rom = Room.new(g_id,w_id,gen_content_from_pool(content_list),0)
		dat.append(rom)
		
	return dat
func gen_level_1():
	
	var level = []
	
	level.append(gen_shop_room())
	
	var e_content = gen_content_list_from_pool(2, [ [0,0] , [0,1] ])
	e_content = e_content + [[0,0] , [0,1] , [0,0] ]
	#print(e_content)
	var bl = gen_from_list(1,1, e_content )
	
	for e in bl:
		
		level.append(e)
		
	
	
	
	e_content = gen_content_list_from_pool(2,	[ [0,1] , [0,2] ]) #, [0,1] ] )
	
	e_content = e_content + [ [0,1] , [0,1] , [0,2] ]
	var bl2 = gen_from_list(2,2, e_content )
	
	for e2 in bl2:
		
		level.append(e2)
		
	#TODO AFTER ALPHA BUILD
	#level.append(Room.new(2,2,[1,1],0))
	
	#var bl3 = gen_from_pool(2,2,2, [ [0,1] , [0,2] ] )
	
	
	#for e3 in bl3:
		
	#	level.append(e3)
		
	level.append(Room.new(2,2,[3,0],0))
		

	return level
	
	
func gen_level_2():
	
	var level = []
	
	level.append(gen_shop_room())
	
	
	
	var e_content = gen_content_list_from_pool(2,[ [0,0] , [0,1] ])
	e_content = e_content + [ [0,0] , [0,1]]
	
	#var pack = gen_from_pool(3,1,1,[ [0,0] , [0,1] ])
	var pack = gen_from_list(1,1,e_content)
	
	for r in pack:
		
		level.append(r)
		
	
	var pack_l = gen_content_list_from_pool( 1 , [ [0,2] , [0,3] ])
		
	pack_l = pack_l +[ [0,2] , [0,2] , [0,2] , [0,3] , [0,3] ]
	
	#print (pack_l)
	pack = gen_from_list( 2 , 2 , pack_l )
		
	#print (pack)
	#pack = gen_from_pool(6,3,3,[ [0,2],[0,3],[0,3] ])
	
	for r in pack:
		
		level.append(r)
		
	level.append(Room.new(3,4,[3,0],0))
	
	
	return level
	
	
func gen_level_test():
	
	var level = []
	
	level.append(gen_shop_room())
#	level.append(Room.new(3,3,[0,0],0))

#	level.append(Room.new(3,3,[0,2],0))
	
#	level.append(Room.new(3,3,[1,1],0))
	
	level.append(Room.new(2,2,[0,0],0))
	level.append(Room.new(2,2,[0,5],0))
	
	level.append(Room.new(2,2,[0,9],0))
	level.append(Room.new(2,2,[0,1],0))
	
	level.append(Room.new(2,2,[3,0],0))
	
	return level
		
		
func gen_level_3():
	
	var level = []
	
	level.append(gen_shop_room())
							#TODO: Forest Sprite
	var pack = gen_from_list( 1 , 1 , [ [0,2] , [0,3] , [0,5] , [0,0] ])
	
	for r in pack:
		
		level.append(r)
		
	pack = gen_from_list( 3 , 3 , [ [0,4] , [0,4] , [0,2] , [0,2] , [0,5] , [0,4]])
		
	for r in pack:
		
		level.append(r)
	
	
	level.append(Room.new(1,1,[3,0],0))
	
	return level
	
	
func gen_level_4():
	
	var level = []
	
	level.append(gen_shop_room())
	
	
	var pack = gen_from_list( 1 , 1 , [ [0,6] , [0,5] , [0,5] , [0,2] ]) #, [0,2] , [0,2] , [0,4] , [0,4]])
		
	for r in pack:
		
		level.append(r)
	
	level.append(Room.new(2,2,[0,7],0))
	level.append(Room.new(2,2,[0,4],0))
	
	var d_list = gen_content_list_from_pool(1, [ [0,5] , [0,7] ])
	d_list = d_list + [  [0,4] , [0,5] , [0,5] ]
	pack = gen_from_list( 1 , 1 , d_list)
	
	for r in pack:
		
		level.append(r)
	
	level.append(Room.new(2,2,[3,0],0))
	
	return level
	
	
func gen_level_5():
	
	var level = []
	
	level.append(gen_shop_room())
	
	
	var pack = gen_from_list( 1 , 1 , [ [0,5] , [0,5] , [0,5] , [0,7] , [0,8] , [0,6]]) 
		
	for r in pack:
		
		level.append(r)
	

	
	var d_list = [ [0,9] , [0,9] , [0,9] , [0,8] , [0,5] , [0,5] ]
	pack = gen_from_list( 2 , 2 , d_list)
	
	for r in pack:
		
		level.append(r)
	
	level.append(Room.new(2,2,[3,0],0))
	
	return level
	
	
func gen_level_6():
		
		
		var level = []
	
		level.append(gen_shop_room())
	
	
		var pack = gen_from_list( 1 , 1 , [ [0,4] , [0,4] , [0,5] , [0,5] , [0,5] , [0,7] , [0,9] ] )
		
		for r in pack:
		
			level.append(r)
			
		level.append(Room.new(2,2,[0,11],0))
		
		level.append(Room.new(2,2,[0,10],0))
		
		
		pack = gen_from_list( 2 , 2 , [ [0 , 8] , [0,8] , [0,9] ] )
		
		for r in pack:
		
			level.append(r)
		
		level.append(Room.new(2,2,[3,0],0))
		
		return level
		
func gen_level_7():
	
	var level = []
	
	var pack = gen_from_list( 1 , 1 , [ [0,10] , [0,7] , [0,9] , [0,8] ] ) 
	
	for r in pack:
		
		level.append(r)
		
	level.append(Room.new(2,2,[0,13],0))
	
	var d_content = gen_content_list_from_pool( 3 , [ [0,12] , [0,10] ] )
	
	d_content = d_content + [ [0,13] , [0,7] , [0,8] ]
	
	pack = gen_from_list( 2 , 2 , d_content)
	
	
	for r in pack:
		
		level.append(r)
	
	level.append(Room.new(2,2,[3,0],0))
		
	return level
		
		