extends Node2D

var linked

var size
var current = 0
var items_hook = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func connect_object(obj : Object_Class):
	linked = obj
	
func begin_pos_thing(size_v):

	current = -1
	size = size_v
	
func get_next_item_pos():
	
	if current == 2 and size == 3:
		current += 2
	elif current in [1,4] and size == 4:
		current += 2
	else:
		current += 1
		
	return current
	
func create_sprite(rect):
	
	var sp = Sprite.new()
	sp.texture = load('res://Ressources/items.png')
	sp.region_enabled = true
	sp.region_rect.position = rect
	sp.region_rect.size = Vector2(16,16)
	sp.centered = false
	
	return sp
	
func get_pos_coordinates(pos,c_line):
	
	var x = ( pos % 3 ) * 24
	var y = floor(pos / 3) * 16
	
	if pos == 6:
		y=8
		x = 48
		
	y += c_line * 16
		
	#return Vector2(x + $Sprite.position.x,y + $Sprite.position.y)
	return Vector2(x,y)
	
func place_item_helper(id,pos_id,c_line,big = false):
	
	#print('placing a sprite')
	var sprite = create_sprite(progression_manager.get_item_sprite(id))
	
	sprite.position = get_pos_coordinates(pos_id,c_line)
	if big:
		sprite.scale = Vector2(1.2,1.2)
	else:
		sprite.scale = Vector2(0.8,0.8)
		sprite.position.x += 2
		sprite.position.y += 2
	
	$Sprites.add_child(sprite)
	
func change_sprite(n,rect):
	
	$Sprites.get_child(n).region_rect.position = rect
	
func build():
	
	if linked.get_class() == 'Crafter':
		
		var recipes = linked.recipe_list
		
		var c_line = 0
		
		for r in recipes:
			
			begin_pos_thing(len(r.reagents))
			
			for re in r.reagents:
				
				place_item_helper(re,get_next_item_pos(),c_line)
				
				if not re in items_hook:
					items_hook.append(re)
			
			place_item_helper(r.result,get_next_item_pos(),c_line,true)
			if not r.result in items_hook:
					items_hook.append(r.result)
			
			c_line += (len(r.reagents) + 1) / 2
			
	else:
		
		$Sprite.modulate = Color(1,0,0)
		
		
func update_sprites(new_id):
		
		var recipes = linked.recipe_list
		
		var c_sprite = 0
		
		for r in recipes:
	
			for re in r.reagents:
				
				if re == new_id:
					
					change_sprite(c_sprite,item_manager.get_item_sprite(re))
					
				c_sprite += 1
				
			if r.result == new_id:
					
				change_sprite(c_sprite,item_manager.get_item_sprite(r.result))
					
			c_sprite += 1
					