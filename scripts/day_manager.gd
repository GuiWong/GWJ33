extends Node

var current_time = 0
var current_day = 0

signal dawn_start
signal morning_start
signal day_start
signal evening_start
signal dusk_start
signal night_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_dawn():
	
	current_day += 1
	current_time = 1
	emit_signal("dawn_start")
	
	
func start_morning():
	
	current_time = 2
	emit_signal("morning_start")
	
func start_day():

	current_time = 3
	emit_signal('day_start')
	
func start_evening():

	current_time = 4
	emit_signal('evening_start')
	
func start_dusk():

	current_time = 5
	emit_signal('dusk_start')
	
func start_night():

	current_time = 6
	
	
func has_day_passed():
	
	return current_time >= 4
	
func start_sleep():
	
	start_dawn()
	
	
