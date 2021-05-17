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
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func load_monsters():
	monsters.append(load('res://Entity/Monsters/Sprout.tscn'))
	monsters.append(load('res://Entity/Monsters/Slime.tscn'))


func get_monster_data(i):
	
	return monster_data[i].duplicate()
	
func get_monster_rect_pos(i):
	
	return monster_texture[i]
