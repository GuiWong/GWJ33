extends Interactable
class_name Storage_Object


export(int) var slots = 1
#export(int) var 

# Called when the node enters the scene tree for the first time.
func _ready():
	slots = $Slots.get_child_count()

func get_item_in_slot(i):
	return $Slots.get_child(i).get_child(0)
	
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