extends Crafter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_recipe(Recipe.new(5,5,[1,4]))
	add_recipe(Recipe.new(17,5,[10,16]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
