extends Node2D
class_name Item

export(int) var id
export(int) var stack_size
export(int) var quantity
export(int) var price

func get_class(): 
	return "Item"
# Called when the node enters the scene tree for the first time.
func _ready():
	set_id(id)
	set_quantity(quantity)
	set_sprite(item_manager.get_item_sprite(id))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_id(n_id):
	id = n_id
	#$Sprite.region_rect.position.x = id *16
	#$Label.text = str(id)
	
func set_sprite(v : Vector2):
	
	$Sprite.region_rect.position = v
	
func set_quantity(q):
	quantity = q
	if q > 1:
		$Label.text = str(q)
	else:
		$Label.text = ''
		
func set_stack_size(v):
	
	stack_size = v
	
func set_price(p):
	
	price = p
	
func on_interaction(thing):
	return true