extends Node

var item_data = []
var item_file = 'res://Data/Items.txt'
var item_scene = preload("res://Item/Item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#load_item_data()
	
func store_data(raw):
	
	var new_dat = []
	new_dat.append(int(raw[0]))
	new_dat.append(int(raw[1]))
	new_dat.append(raw[2])
	new_dat.append(int(raw[3]))
	new_dat.append(int(raw[4]))
	
	item_data.append(new_dat)

func load_item_data():
	
	var f = File.new()
	f.open(item_file,f.READ)
	var line
	var done = false
	while not done:
		line = f.get_line()
		if not line:
			done = true
		else:
			if not line.split(';')[0] in ['Wong_Data_0','Id']:
				store_data(line.split(';'))
				
				
				
func get_item_price(id):
	
	return item_data[id][3]
	
func get_item_stack_size(id):
	
	return item_data[id][4]
	
func get_item_name(id):
	
	return item_data[id][2]
	
func get_item_sprite(id):
	
	var pos = Vector2()
	pos.x = ( item_data[id][1] % 8 ) * 16
	pos.y = floor( item_data[id][1] / 8 ) * 16
	
	return pos

func get_item_count():
	
	return len(item_data)
	
func create_item(id,quantity):
	
	var new_item = item_scene.instance()
	new_item.set_id( id )
	new_item.set_quantity(quantity)
	new_item.set_price(get_item_price(id))
	new_item.set_stack_size(get_item_stack_size(id))
	new_item.set_sprite(get_item_sprite(id))
	progression_manager.discover(id)
	return new_item
	
	
	