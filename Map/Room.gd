extends Node2D


		
var shop_room
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func get_monster_pos():
	
	return $Monster_pos.position

func load_room(room ):
 	
	var g_tex = "res://Ressources/rooms/ground" + str(room.ground) +".png"
	$Ground.texture = load(g_tex)
	var b_tex = "res://Ressources/rooms/wall" + str(room.back) +".png"
	$Back.texture = load(b_tex)