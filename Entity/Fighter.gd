extends Entity
class_name Fighter
# Declare member variables here. Examples:

export(int) var pv
export(int) var attack
export(int) var attack_type
export(int) var attack_time
signal animation_done


# Called when the node enters the scene tree for the first time.
func _ready():
	
	update_pv_bar()
	
func update_pv_bar():
	
	$PvBar.update_value(pv)

func take_damage(q):
	
	pv -= q
	
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