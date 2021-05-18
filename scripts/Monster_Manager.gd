extends Node

var monsters = []
var monster_data = [ [2,1,1,6],
						[2,1,0,7],
						[4,2,0,8]
					]
					
var monster_texture = [ [0,0],
						[64,0],
						[0,64]
					]
					
var monster_loot = [ [ 1 ] ,
					[ 0 ],
					[ 4 ]
					
					]
					
var monster_gold = [2,1,5]
# Called when the node enters the scene tree for the first time.
func _ready():
	load_monsters()


func load_monsters():
	monsters.append(load('res://Entity/Monsters/Sprout.tscn'))
	monsters.append(load('res://Entity/Monsters/Slime.tscn'))
	monsters.append(load('res://Entity/Monsters/Skeleton.tscn'))

func create_monster_node(id):
	
	var n = monsters[id].instance()
	return n

func get_monster_data(i):
	
	return monster_data[i].duplicate()
	
func get_monster_rect_pos(i):
	
	return monster_texture[i]
	
func get_loot(i):
	
	return monster_loot[i]
	
func get_gold_loot(i):
	
	return monster_gold[i]
