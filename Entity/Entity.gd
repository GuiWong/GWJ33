extends KinematicBody2D
class_name Entity

var lin_vel = Vector2.ZERO
export(int) var max_speed = 200
var speed = 0
var dir = Vector2.ZERO
var accel = 50
var deccel = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(delta):
	
	speed = min(max_speed,speed + accel )
	
func stop(delta):
	
	speed = max(0,speed - deccel )
	
func set_texture_rect(x,y):
	
	$Sprite.region_rect.position.x = x
	$Sprite.region_rect.position.y = y
	
func go_to_point(point,delta):
	
	dir = point - position
	move(delta)
	move_and_slide(speed * dir.normalized())
	if (point - position).length() <= 4:
		return true
	else:
		return false