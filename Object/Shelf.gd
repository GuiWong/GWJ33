extends Storage_Object
class_name Shelf

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Sprite.region_rect.position.x = 64
	pass
	
func empty_item():
	
	drop_item_from_slot(0)
	delete_price()
	
func can_empty():
	
	return get_item_in_slot(0) != null
	
	
func delete_price():
	
	$Label.text = ''
	
func add_item(item : Item):
	add_item_in_slot(0,item)
	$Label.text = str(item.price * item.quantity)
	if item.quantity == 1:
		$Slots/s1.scale.x = 2
		$Slots/s1.scale.y = 2
	else:
		$Slots/s1.scale.x = 1
		$Slots/s1.scale.y = 1
	
	
func on_interaction(item ):
	
	if can_interact(item):
	
		
		
		
		add_item(item)
		return false
	else:
		return item
			
			
func can_interact(item):
	
	if item != null:
	
		if get_item_in_slot(0) == null and (item.id in global.consumables or item.id in global.upgrades):
		
			return true
		
	else:
		
		return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
