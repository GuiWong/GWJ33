extends Node

signal fight_end
var combat_tick = 0
var is_waiting = false

var fighter = []

var action_queue = []

var running_anim = 0
var finished_anim = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calc_attack_weight(f_id):
	
	return max(0,fighter[f_id].attack - fighter[abs(f_id - 1)].armor_class[0]) * 5
	
func calc_special_attack_weight(f_id,att_c):
	
	if fighter[f_id].charges[att_c] >= 1:
		return fighter[f_id].charges[att_c] + 2 * fighter[abs(f_id - 1)].armor_class[0] - 3 * fighter[abs(f_id - 1)].armor_class[att_c + 1]
	else:
		return 0
		
func calc_heal_weight(f_id,h_str):
	
	return max(0, (fighter[f_id].pv - h_str ) / fighter[f_id].base_pv - h_str) * 15 + 1

func load_fighter(f1 : Fighter,f2 : Fighter):
	
	fighter = [f1,f2]
	
	if len(f1.get_signal_connection_list('animation_done')) >= 1:
		pass
	else:
		f1.connect('animation_done',self,'animation_waiter')
		
	if len(f2.get_signal_connection_list('animation_done')) >= 1:
		
		pass
		
	else:
		
		f2.connect('animation_done',self,'animation_waiter')
	
#	print(f2.get_signal_connection_list('animation_done')[0].get('method' )
	
func start_fight():
	
	combat_tick = 0
	running_anim = 0
	finished_anim = 0
	action_queue = []
	plan_next_attack(0)
	plan_next_attack(1)
	
	is_waiting = false

func choose_action(attacker):
	
	var weight = calc_attack_weight(attacker)
	var type = 0
	
	var n_w = calc_heal_weight(attacker,4)
	if n_w > weight:
		weight = n_w
		type = 1
		
	for sp_t in range(2):
		
		n_w = calc_special_attack_weight(sp_t,attacker)
		if n_w > weight:
			weight = n_w
			type = 2 + sp_t
		
	
		
	#TODO: Special Attack
	#for i in range(2)
	
	return type
		
func plan_next_attack(attacker,instant = false):
	
	var f
	
	var type = choose_action(attacker)
	if instant or type == 1:
		f = combat_tick
	else:
		f = combat_tick + fighter[attacker].attack_time
	if len(action_queue) < 1:
		action_queue.append([f,attacker,type])
	else:
		var inserted = false
		for a in range(len(action_queue)):
			if f < action_queue[a][0]:
				action_queue.insert(a,[f,attacker,type])
				inserted = true
			if not inserted:
				action_queue.append([f,attacker,type])
			
func animation_waiter():
	finished_anim += 1
	if finished_anim >= running_anim:
		is_waiting = false
		
		
	#print('animations : ' + str(finished_anim) + ' - ' + str(running_anim) )
	
func solve_attack(attacker):
	
	var type = action_queue[0][2]
	action_queue.remove(0)
	plan_next_attack(attacker)
	
	is_waiting = true
	
	
	if type == 0:
	
		var raw = fighter[attacker].attack
		
		raw = max(0,raw - fighter[abs(attacker-1)].armor_class[fighter[attacker].attack_type])
	
		var damage
	
		if raw > 0:
		
			damage = max( 1 , raw - fighter[abs(attacker-1)].defence)
		
		else:
		
			damage = raw
	#print(fighter[attacker].name +' is attacking for ' + str(damage) +' damage')
	
		apply_damage(attacker,damage)
			
		fighter[attacker].play_attack()
		running_anim += 1
	
	elif type == 1:
		
		fighter[attacker].use_heal()
	
	elif type >= 2:
		
		var damage = calc_special_result(type - 2 , attacker)
		
		apply_damage(attacker,damage)
		
		fighter[attacker].use_special(type - 2)
		
		
	
		
	
	
func apply_damage(attacker,damage):
	
	fighter[abs(attacker-1)].take_damage(damage)
	
	if fighter[abs(attacker-1)].pv <= 0:
		
		emit_signal("fight_end")
		is_waiting = true
		fighter[abs(attacker-1)].play_die()
		running_anim += 1
		
	else:
		
		if damage == 0:
				
			fighter[abs(attacker-1)].play_parry()
							
		else:
			fighter[abs(attacker-1)].play_hit()
			running_anim += 1
			
			
func calc_special_result(sp_id,attacker):
	
	var raw = fighter[attacker].strenghts[sp_id]
	
	raw = max( 0 , raw - fighter[abs(attacker)-1].armor_class[sp_id + 1] )
	
	var damage = raw
	
	if raw > 0:
		
		damage = max( 1 , raw - fighter[abs(attacker-1)].defence)
		
	return damage
		
	
	
	
func check_tick():
	
	if combat_tick == action_queue[0][0]:
		solve_attack(action_queue[0][1])
	else:
		combat_tick+=1
	
	
func fight_tick():
	
	if not is_waiting:
		
		check_tick()
		#print(combat_tick)
	else: 
		#print('waiting')
		pass
