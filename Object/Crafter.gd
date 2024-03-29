extends Storage_Object
class_name Crafter


class Recipe:
	#var reagent_1
	#var reagent_2
	#var reagent_3
	var reagents = []
	var result
	var qtty
	func _init(res,quant,reagent):#r1,r2=null,r3=null):
		result=res
		qtty=quant
		reagents = reagent.duplicate()
		#reagent_1=r1
		#reagent_2=r2
		#reagent_3=r3
		
var recipe_list = []
var current_step = 0
var product_pos = 0
var recipe_match = []
var has_finished = false



var once_each = false
var recipe_queue = []



func can_empty():
	
	if current_step >= 1:
		
		return true
	
func empty_item():
	
	drop_item_from_slot(current_step-1)
	Sound_Manager.drop_item()
	current_step -= 1
	if current_step <= 0:
		reset_recipe_match()
	
func get_class(): 
	return "Crafter"
	
	
func load_next_recipe():
	
	if len(recipe_queue) >= 1:
		recipe_list = []
		add_recipe(recipe_queue[0])
		
		recipe_queue.remove(0)
		if linked_updatable != null:
			
			linked_updatable.re_load()
	
func add_recipe(recip):
	recipe_list.append(recip)
	recipe_match.append(true)
	
func queue_recipe(recip):
	
	recipe_queue.append(recip)
	
func reset_recipe_match():
	
	current_step = 0
	for a in len(recipe_match):
		
		recipe_match[a] = true
		
	#print( recipe_match)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func check_reagent(item):
	
	for n in range(len(recipe_list)):
		if len(recipe_list[n].reagents) <= current_step:
			pass
		elif recipe_match[n] and item.id == recipe_list[n].reagents[current_step]:
			return true
	return false
	

func add_reagent(item):
	add_item_in_slot(current_step,item)
	
	for i in range(len(recipe_list)):
		
		if current_step >= len(recipe_list[i].reagents):
			recipe_match[i] = false
		elif item.id == recipe_list[i].reagents[current_step]:
			recipe_match[i] = true
		else:
			recipe_match[i] = false
	current_step += 1
	
func solve_craft(c_n):
	
		for i in range(len(recipe_list[c_n].reagents)):
			
			remove_item_in_slot(i)
			
		#for j in recipe_match:
			
		#	j = true
			
		add_item_in_slot(len(recipe_list[c_n].reagents),item_manager.create_item(recipe_list[c_n].result,recipe_list[c_n].qtty))
		current_step = 0
		product_pos = len(recipe_list[c_n].reagents)
		reset_recipe_match()
		has_finished = true
		
		
		if once_each:
			
			load_next_recipe()
		
		#get_item_in_slot(product_pos).price = 20
	
func check_completion():
	
	for i in range(len(recipe_list)):
		
	#	print('step: ' + str(current_step) + 'recipe lenght : ' + str(len(recipe_list[i].reagents)))
		if current_step == len(recipe_list[i].reagents) and recipe_match[i]:
			
			solve_craft(i)

func on_interaction(item):
	
	#print (item)
	if item != null and not has_finished:
		if check_reagent(item):
			add_reagent(item)
			check_completion()
			
			Sound_Manager.grab_item()
			
			return false
		else:
			return item
			
	elif has_finished:
		
	#	print('product done')
		var new = get_item_in_slot(product_pos)
		remove_item_in_slot(product_pos)
		#reset_recipe_match()
		product_pos = 0
		has_finished = false
		return new
		
	return false
		
func can_interact(item):
	
	if item != null and check_reagent(item) and not has_finished:
		
		return true
		
	elif item == null and has_finished:
		
		
		return true
		
	else:
		
		return false
		 
