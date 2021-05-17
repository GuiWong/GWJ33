extends Storage_Object
class_name Shelf

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Sprite.region_rect.position.x = 64
	pass
	
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
	
	#print(get_item_in_slot(0))
	if item != null and get_item_in_slot(0) == null:
		
		add_item(item)
		return false
	else:
		return item

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
