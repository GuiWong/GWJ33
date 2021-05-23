extends Interactable
class_name Storage_Object


export(int) var slots = 1
#export(int) var 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#slots = $Slots.get_child_count()
	pass
	
	
func drop_item_from_slot(i):
	
	var itm = get_item_in_slot(i)
	
	remove_item_in_slot(i)
	get_parent().add_child(itm)
	itm.position = position + Vector2(0,32)
	
func empty_item():
	
	pass
	

func get_item_in_slot(i):
	if $Slots.get_child(i).get_child_count() >= 1:
		return $Slots.get_child(i).get_child(0)
	else:
		return null
	
func add_item_in_slot(i,item):
	$Slots.get_child(i).add_child(item)
	on_content_changed()
	
func add_item_count_in_slot(i,qtty):
	$Slots.get_child(i).get_child(0).set_quantity($Slots.get_child(i).get_child(0).quantity + qtty)
	on_content_changed()
	
func remove_item_count_in_slot(i,qtty):
	$Slots.get_child(i).get_child(0).set_quantity($Slots.get_child(i).get_child(0).quantity - qtty)
	on_content_changed()
	
func remove_item_in_slot(i):
	
	$Slots.get_child(i).remove_child(get_item_in_slot(i))
	on_content_changed()
	

func on_content_changed():
	
	pass
	
func can_interact(item):
	
	if item != null:
		
		return true
		
	else:
		
		return false
