extends Crafter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_recipe(Recipe.new(13,1,[11,10,10]))
	queue_recipe(Recipe.new(21,1,[11,20,20]))
	once_each = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
