extends Node

signal fight_end
signal special_used(a,i)
var combat_tick = 0
var is_waiting = false
var is_finished = false

var fighter = []

var action_queue = []
var animation_queue = []

var running_anim = 0
var finished_anim = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calc_attack_weight(f_id):
	
	return max(0,fighter[f_id].attack - fighter[abs(f_id - 1)].armor_class[0]) * 5 + 1
	
func calc_special_attack_weight(f_id,att_c):
	
	if fighter[f_id].charges[att_c] >= 1:
		
		#print('Fighter ' + str(f_id) + ' has ' +str(fighter[f_id].charges[att_c]) +' charges usable for special attack ' +str(att_c))
		#var d_x = 0
		
		#if 	fighter[f_id].strenghts[att_c] == 3:
			
		#	d_x = 6
			
		if fighter[f_id].strenghts[att_c]  == 3 or fighter[f_id].strenghts[att_c] == 8:
			
			#print ('other algo')
			return 4 * ( fighter[f_id].strenghts[att_c] - fighter[abs(f_id - 1)].armor_class[att_c + 1] )
			
		else:
											
			return fighter[f_id].charges[att_c] + 2 * fighter[abs(f_id - 1)].armor_class[0]  -  3 * fighter[abs(f_id - 1)].armor_class[att_c + 1] 
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
	
func end_fight():
	
	combat_tick = 0
	running_anim = 0
	finished_anim = 0
	action_queue = []
	is_finished = false
	is_waiting = false
	
func start_fight():
	
	
	if is_finished:
		pass
	else:
		end_fight()
		plan_next_attack(0)
		plan_next_attack(1)
	

func choose_action(attacker):
	
	
	#if attacker == 1:
		
	#	return 0
		
		
	var weight = calc_attack_weight(attacker)
	var type = 0
	
	var n_w = calc_heal_weight(attacker,4)
	if n_w > weight:
		weight = n_w
		type = 1
		
	for sp_t in range(2):
		
		n_w = calc_special_attack_weight(attacker,sp_t)
		if n_w > weight:
			weight = n_w
			type = 2 + sp_t
		
	
		
	#TODO: Special Attack
	#for i in range(2)
	
	#print(attacker, type , weight)
	
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
				
				
func use_heal(attacker):
	
	fighter[attacker].use_heal()
	emit_signal('special_used',attacker,0)
	is_waiting = true
	#running_anim += 1
	
			
func reset_anims():
	running_anim = 0
	finished_anim = 0
func animation_waiter(heal = false):
	
	if not heal:
		finished_anim += 1
	
	#print(animation_queue)
	
	if len(animation_queue) >= 1:
		
		if animation_queue[0][1] == 0:	
			fighter[animation_queue[0][0] ].play_hit()
			running_anim += 1
		else:
			fighter[animation_queue[0][0] ].play_die()
			running_anim += 1
			
		animation_queue.remove(0)
		
	if finished_anim >= running_anim and running_anim >= 1:
		
		is_waiting = false
		
		if is_finished:
			
			if fighter[0].heal_charges >= 1 and fighter[0].base_pv - fighter[0].pv > fighter[0].heal_strenght:
				is_waiting = true
				use_heal(0)
			else:
				emit_signal("fight_end")
				reset_anims()
		
		
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
	
		apply_damage(attacker,damage,true)
			
		fighter[attacker].play_attack()
		running_anim += 1
	
	elif type == 1:
		
		#fighter[attacker].use_heal()
		#emit_signal('special_used',attacker,1)
		#is_waiting = true
		#running_anim += 1
		use_heal(attacker)
	
	elif type >= 2:
		
		var damage = calc_special_result(type - 2 , attacker)
		
		apply_damage(attacker,damage,true)
		
		fighter[attacker].use_special(type - 2)
		
		emit_signal('special_used',attacker,type-1)
		
		running_anim += 1
		
		
	
		
	
	
func apply_damage(attacker,damage,instant = false):
	
	fighter[abs(attacker-1)].take_damage(damage)
	
	if fighter[abs(attacker-1)].pv <= 0 and fighter[abs(attacker-1)].heal_charges <= 0:
		

		
		is_finished = true
		#emit_signal("fight_end")
		is_waiting = true
		
		if instant:
			
			fighter[abs(attacker-1)].play_die()
			running_anim += 1
		else:
			animation_queue.append([abs(attacker-1),1])
		
		
		
	else:
		
		if damage == 0:
				
			fighter[abs(attacker-1)].play_parry()
			running_anim += 1
			
		elif fighter[abs(attacker-1)].pv <= 0:
			
			use_heal(attacker)
							
		else:
			
			if instant:
				fighter[abs(attacker-1)].play_hit()
				running_anim += 1
			else:
				animation_queue.append([abs(attacker-1),0])
			
			
			
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
