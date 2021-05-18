extends Entity


var is_holding = false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	dir = Vector2.ZERO
	if Input.is_action_pressed('up'):
		dir.y -= 1
		$Interact_area.rotation_degrees = 0
		$Sprite.region_rect.position.y = 64
		$Sprite.flip_h = false
		#rotation_degrees = 0
		#$Hand.rotation_degrees = 0
	elif Input.is_action_pressed('down'):
		dir.y += 1
		$Interact_area.rotation_degrees = 180
		$Sprite.region_rect.position.y = 0
		$Sprite.flip_h = false
		#rotation_degrees = 180
		#$Hand.rotation_degrees = -180
	if Input.is_action_pressed('left'):
		dir.x -= 1
		$Interact_area.rotation_degrees = 270
		$Sprite.region_rect.position.y = 128
		$Sprite.flip_h = true
		#rotation_degrees = 270
		#$Hand.rotation_degrees = -270
	elif Input.is_action_pressed('right'):
		dir.x += 1
		$Interact_area.rotation_degrees = 90
		$Sprite.region_rect.position.y = 128
		$Sprite.flip_h = false
		#rotation_degrees = 90
		#$Hand.rotation_degrees = -90
		
	if Input.is_action_just_pressed('a'):
		var l = $Interact_area.get_overlapping_areas()
		if len(l) > 0:
			

			var temp  = l[0].on_interaction()
			#print(temp.get_parent().get_parent().get_class())
			if temp.get_class() == 'Item':
				if is_holding:
					pass
					
				elif temp.get_parent().get_parent().get_class() != 'Slots':
					temp.get_parent().remove_child(temp)
					temp.position = Vector2.ZERO
					$Hand.add_child(temp)
					is_holding = true
			elif temp.get_class() in [ 'Interactable' , 'Crafter' , 'Storage_Object']:
				var itm = $Hand.get_child(0)
				$Hand.remove_child(itm)
				var new = temp.on_interaction(itm)
				if new:
					$Hand.add_child(new)
					is_holding = true
				else:
					is_holding = false
	if Input.is_action_just_pressed('b'):
		if is_holding:
			is_holding = false
			var temp = $Hand.get_child(0)
			$Hand.remove_child(temp)
			temp.position = $Interact_area.global_position
			
			get_parent().add_child(temp)
		
	if dir.length() != 0:
		move(delta)
	else:
		stop(delta)
		
	lin_vel = dir.normalized() * speed
	move_and_slide(lin_vel)
