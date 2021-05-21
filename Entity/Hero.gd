extends Fighter
class_name Hero

var sword_level = 1
var shield_level = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#end_animation()
	pass
	
func resurect():
	
	$AnimationPlayer3.play('resurect')

func apply_equipement():
	
	attack = sword_level
	defence = shield_level
	
	armor_class[1] = shield_level
	
func can_equip(id):
	
	if id == 3 and shield_level == 0:
		
		return true
		
	elif id == 13 and sword_level < 2:
		
		return true
		
	elif id == 14 and shield_level < 2:
		
		return true
		
	else:
		
		return false
		
func equip_item(id):
	
	if id == 3:
		
		shield_level = 1
		
		$Sprite3.visible = true
		
	elif id == 13:
		
		sword_level = 2
		
		
func use_heal():
	
	if heal_charges >= 1:
		heal(heal_strenght)
		heal_charges -= 1
		emit_signal("charge_used",0,heal_charges)
		update_pv_bar()
		$AnimationPlayer3.play("resurect")
		

