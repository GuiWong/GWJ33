extends Entity
class_name Fighter
# Declare member variables here. Examples:

signal charge_used(id,ql)

export(int) var pv
export(int) var base_pv

export(int) var attack
export(int) var base_attack

export(int) var attack_type


export(int) var attack_time
export(int) var base_attack_time

export var armor_class = [0,0,0]

export(int) var defence

export(int) var heal_charges = 0
var heal_strenght = 4
export var charges = [0,0]

#export(int) var id

signal animation_done


# Called when the node enters the scene tree for the first time.
func _ready():
	
	update_pv_bar()
	
func reset():
	
	pv = base_pv
	attack = base_attack
	attack_time = base_attack_time
	update_pv_bar()
	
func update_pv_bar():
	
	$PvBar.update_value(pv)

func take_damage(q):
	
	pv -= q
	
func heal(q):
	
	pv = min(base_pv,pv + q)
	
func use_heal():
	
	heal(heal_strenght)
	heal_charges -= 1
	emit_signal("charge_used",0,heal_charges)
	
func play_attack():
	
	$AnimationPlayer.play("attack")
	
func play_parry():
	
	$AnimationPlayer.play("parry")
	
func play_hit():
	
	$AnimationPlayer2.play("hit")
	
func play_die():
	
	$AnimationPlayer2.play("die")
	
func end_animation(name = 'noname'):
	
	print('ANIMATION ENDED')
	emit_signal('animation_done')
	
