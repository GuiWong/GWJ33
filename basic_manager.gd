extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func create_item(id,quantity):
	var itm = preload("res://Item/Item.tscn")
	var new_item = itm.instance()
	new_item.set_id( id )
	new_item.set_quantity(quantity)
	return new_item
