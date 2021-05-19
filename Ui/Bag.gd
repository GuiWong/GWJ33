extends Node2D

var total = 0
var gold = 0

var potion = 0
var potion_max = 1

var torch = 0
var torch_max = 5

var arrow = 0
var arrow_max = 5

var bomb = 0
var bomb_max = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_item(item : Item):
	
	$Content.add_child(item)
	item.position = Vector2(total * 16  + 8 , 8)
	total += 1
	#print (item.position)
	
func add_gold(q):
	gold += q
	
	$Inventory/Gold/Label.text = str(gold)
	
func remove_gold(q):
	
	gold = max (0, gold-q)
	$Inventory/Gold/Label.text = str(gold)
	
func store_consumable(id,q):
	
	if has_space_for(id):
		
		if id == 6:
			
			potion = max(potion + q, potion_max)
			$Inventory/Potion/Label.text = str(potion)
			
		elif id == 2:
			
			torch = max(torch + q , torch_max)
			$Inventory/Torch/Label.text = str(torch)
			
		elif id == 5:
			
			arrow = max(arrow + q, arrow_max)
			$Inventory/Arrow/Label.text = str(arrow)
			
		elif id == 9:
			
			bomb = max(bomb + q, bomb_max)
			$Inventory/Bomb/Label.text = str(bomb)
			
			
func update_consumables(i,q):
	
	if i == 0 :
		
		potion = q
		$Inventory/Potion/Label.text = str(potion)
		
	if i == 1:
		
		arrow = q
		$Inventory/Arrow/Label.text = str(arrow)
			
	if i == 2:
			
		bomb = q
		$Inventory/Bomb/Label.text = str(bomb)
			
func use_potion():
	
	potion -= 1
	$Inventory/Potion/Label.text = str(potion)
	
func use_torch():
	
	torch -= 1
	$Inventory/Torch/Label.text = str(torch)
	
func empty_consumables():
	
	torch = 0
	$Inventory/Torch/Label.text = str(torch)
	
	potion = 0
	$Inventory/Potion/Label.text = str(potion)
	
	
func has_space_for(id):
	
	if id == 6 and potion < potion_max:
		
		return true
	
	elif id == 2 and torch < torch_max:
		
		return true
		
	elif id == 5 and arrow < arrow_max:
		
		return true
		
	elif id == 9 and bomb < bomb_max:
		
		return true
	else:
		
		return false
	