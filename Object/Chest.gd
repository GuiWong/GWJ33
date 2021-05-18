extends Storage_Object

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_item(item : Item):
	
	if get_item_in_slot(0) == null:
		add_item_in_slot(0,item)
	else:
		add_item_count_in_slot(0,item.quantity)
		
	$Label.text = str(item.quantity)
	$Slots/s1.scale.x = 1
	$Slots/s1.scale.y = 1
	get_item_in_slot(0).hide_qtty()
	
	
func on_content_changed():
	
	$Label.text = str(get_item_in_slot(0).quantity)
	
func add_money(quantity):
	
	#add_item(item_manager.create_item(7,quantity))
	#if get_item_in_slot(0) == null:
	#	add_item_in_slot(0,item_manager.create_item(7,quantity))
	#	get_item_in_slot(0).hide_qtty()
		
	#else:
			
	add_item_count_in_slot(0,quantity)
		
	#$Label.text = str(quantity)
	
func on_interaction(item ):
	
	#TODO: Create coin item
	if item != null and item.id == 7:
		
		add_item(item)
		return false
	else:
		return item
