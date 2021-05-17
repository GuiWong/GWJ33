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

func load_fighter(f1 : Fighter,f2 : Fighter):
	
	fighter = [f1,f2]
	f1.connect('animation_done',self,'animation_waiter')
	f2.connect('animation_done',self,'animation_waiter')
	
func start_fight():
	
	combat_tick = 0
	running_anim = 0
	finished_anim = 0
	action_queue = []
	plan_next_attack(0)
	plan_next_attack(1)
	
	is_waiting = false

func plan_next_attack(attacker):
	
	var f = combat_tick + fighter[attacker].attack_time
	if len(action_queue) < 1:
		action_queue.append([f,attacker])
	else:
		var inserted = false
		for a in range(len(action_queue)):
			if f < action_queue[a][0]:
				action_queue.insert(a,[f,attacker])
				inserted = true
			if not inserted:
				action_queue.append([f,attacker])
			
func animation_waiter():
	finished_anim += 1
	if finished_anim >= running_anim:
		is_waiting = false
		
		
	#print('animations : ' + str(finished_anim) + ' - ' + str(running_anim) )
	
func solve_attack(attacker):
	
	action_queue.remove(0)
	plan_next_attack(attacker)
	
	is_waiting = true
	
	var damage = fighter[attacker].attack
	
	#print(fighter[attacker].name +' is attacking for ' + str(damage) +' damage')
	
	fighter[abs(attacker-1)].take_damage(damage)
	
	if fighter[abs(attacker-1)].pv <= 0:
		
		emit_signal("fight_end")
		is_waiting = true
		fighter[abs(attacker-1)].play_die()
		running_anim += 1
		
	else:
		
		fighter[abs(attacker-1)].play_hit()
		running_anim += 1
	
	
	
	#lot to do here...
	
	fighter[attacker].play_attack()
	running_anim += 1
	
	
	
	
	
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
