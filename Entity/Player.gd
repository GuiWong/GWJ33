extends Entity


var is_holding = false

signal item_grab
signal item_drop
signal object_used(object_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func get_item_in_hand():
	
	if $Hand.get_child_count() >= 1:
		return $Hand.get_child(0)
	else:
		return null
		
func get_item_selection(item,drop_mode = false):
	
	
	var liste = $Interact_area.get_overlapping_areas()
	var itms = []
	var obj = []
	
	#print ('choosing a target between ' + str(len(liste)) +' candidates')
	
	#for e in liste:
		
		#print (e.get_parent())
	
	if len(liste) == 0:
		
		return null
		
	
	
	else:
		
		var e
		for a in liste:
			
			e = a.get_parent()
			if e.get_class() == 'Item' and e.get_parent().get_parent().get_class() != 'Slots':
				
				itms.append(e)
				
			elif e.get_class() in ['Interactable','Crafter','Storage_Object'] :
				
				if drop_mode == false and e.can_interact(item) :
				
					obj.append(e)
					
				elif drop_mode and e.can_empty():
					
					obj.append(e)
			
	#print(str(len(itms)) +' Items - ' +str(len(obj)) +' objects ')
		
	var selected 
		
	if is_holding or drop_mode:
		
		if len(obj) >= 1:
		
			selected = get_closest_object(obj)#TODO: Wheighted objects
		
		else:
			
			selected = null
		
	else :
		
		if len(itms) >= 1:
			
			selected = itms[0]
			
		elif len(obj) >= 1:
			
			selected = obj[0]
			
		else:
			
			selected = null
			
	return selected
	
	#print(selected)
		

func get_closest_object(liste):
	var closest
	var dist = INF
	
	for n in liste:
		var n_dist = position.distance_to(n.position)
		if n_dist < dist:
			closest = n
			
	return closest
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	dir = Vector2.ZERO
	
	if Input.is_action_pressed('left'):
		dir.x -= 1
		$Interact_area.rotation_degrees = 270
		$Sprite.region_rect.position.y = 128
		$Sprite.flip_h = true
		
		$Arms.region_rect.position.y = 128
		$Arms.flip_h = true
		
		$Arms_up.region_rect.position.y = 128
		$Arms_up.flip_h = true
		#rotation_degrees = 270
		#$Hand.rotation_degrees = -270
	elif Input.is_action_pressed('right'):
		dir.x += 1
		$Interact_area.rotation_degrees = 90
		$Sprite.region_rect.position.y = 128
		$Sprite.flip_h = false
		
		$Arms.region_rect.position.y = 128
		$Arms.flip_h = false
		
		$Arms_up.region_rect.position.y = 128
		$Arms_up.flip_h = false
		#rotation_degrees = 90
		#$Hand.rotation_degrees = -90
		
	if Input.is_action_pressed('up'):
		dir.y -= 1
		$Interact_area.rotation_degrees = 0
		$Sprite.region_rect.position.y = 64
		$Sprite.flip_h = false

		$Arms.region_rect.position.y = 64
		$Arms.flip_h = false
	
		$Arms_up.region_rect.position.y = 64
		$Arms_up.flip_h = false
		#rotation_degrees = 0
		#$Hand.rotation_degrees = 0
	elif Input.is_action_pressed('down'):
		dir.y += 1
		$Interact_area.rotation_degrees = 180
		$Sprite.region_rect.position.y = 0
		$Sprite.flip_h = false
		
		$Arms.region_rect.position.y = 0
		$Arms.flip_h = false
		
		$Arms_up.region_rect.position.y = 0
		$Arms_up.flip_h = false
		#rotation_degrees = 180
		#$Hand.rotation_degrees = -180
	
		
	if Input.is_action_just_pressed('a'):
		#var l = $Interact_area.get_overlapping_areas()
		#if len(l) > 0:
		var selected = get_item_selection(get_item_in_hand())
		
		if selected == null:
			
			pass

		elif selected.get_class() == 'Item':
			selected.get_parent().remove_child(selected)
			selected.position = Vector2.ZERO
			$Hand.add_child(selected)
			is_holding = true
			
			emit_signal('item_grab')
			
			$Arms.visible = false
			$Arms_up.visible = true
			
		elif selected.get_class() in [ 'Interactable' , 'Crafter' , 'Storage_Object']:
			var itm = get_item_in_hand()
				
			if itm:
				$Hand.remove_child(itm)
				
			var new = selected.on_interaction(itm)
			
			emit_signal('object_used',selected.name)
			
			if new:
				$Hand.add_child(new)
				
				is_holding = true
				
				$Arms.visible = false
				$Arms_up.visible = true
			
			
			else:
				is_holding = false
				
				$Arms.visible = true
				$Arms_up.visible = false
					
	if Input.is_action_just_pressed('b'):
		if is_holding:
			is_holding = false
			$Arms.visible = true
			$Arms_up.visible = false
			var temp = $Hand.get_child(0)
			$Hand.remove_child(temp)
			temp.position = $Interact_area.global_position
			
			emit_signal('item_drop')
			
			get_parent().add_child(temp)
			
		else:
			
			var selected = get_item_selection(null,true)
			if selected:
				selected.empty_item()
		
	if dir.length() != 0:
		move(delta)
		$AnimationPlayer.play('Walk')
	else:
		stop(delta)
		
		
	lin_vel = dir.normalized() * speed
	move_and_slide(lin_vel)
	
	if speed <= 2:
		$AnimationPlayer.play('Idle')
