extends Node

var monsters = []
#var monster_data = [ [2,1,1,6],
	#					[2,1,0,7],
	#					[4,2,0,8]
	#				]
					
#var monster_texture = [ [0,0],
#						[64,0],
#						[0,64]
#					]
					
var monster_loot = [ [ 1 ] ,
					[ 0 ],
					[ 4 ],
					[ 8 ],
					[ 10 ],
					[ 11 ],
					[ 1 ],
					[ 12 ],
					[ 4 , 10 ],
					[ 16 ] ,
					[ 18 ] ,
					[ 19 ],
					[ 11 , 11 ],
					[ 22 ]
					
					
					]
					
var monster_gold = [2,1,5,6,
					15,5,5,20,
					10,15 , 10 , 25,
					10 , 50 ]
# Called when the node enters the scene tree for the first time.
func _ready():
	#load_monsters()
	pass

func load_monsters():
	
	
	# Places to update:
	#- $World add a null monster node monster nodes
		#TODO: Create them from list
	monsters.append(load('res://Entity/Monsters/Sprout.tscn'))
	monsters.append(load('res://Entity/Monsters/Slime.tscn'))
	monsters.append(load('res://Entity/Monsters/Skeleton.tscn'))
	monsters.append(load('res://Entity/Monsters/Boomer.tscn'))
	monsters.append(load('res://Entity/Monsters/Rock.tscn'))
	monsters.append(load('res://Entity/Monsters/Horned_Bat.tscn'))
	monsters.append(load('res://Entity/Monsters/Sprouter.tscn'))
	monsters.append(load('res://Entity/Monsters/Cow.tscn'))
	monsters.append(load('res://Entity/Monsters/Skeleton_Armored.tscn'))
	monsters.append(load('res://Entity/Monsters/Snake.tscn'))
	monsters.append(load('res://Entity/Monsters/Boomer_Hardened.tscn'))
	monsters.append(load('res://Entity/Monsters/Magic_Thing.tscn'))
	monsters.append(load('res://Entity/Monsters/Two_headed_Bat.tscn'))
	monsters.append(load('res://Entity/Monsters/Crystal.tscn'))

func create_monster_node(id):
	
	var n = monsters[id].instance()
	return n

#func get_monster_data(i):
	
#	return monster_data[i].duplicate()
	
#func get_monster_rect_pos(i):
	
#	return monster_texture[i]
	
func get_loot(i):
	
	return monster_loot[i]
	
func get_gold_loot(i):
	
	return monster_gold[i]
