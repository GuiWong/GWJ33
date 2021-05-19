extends Crafter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_recipe(Recipe.new(9,5,[8,0]))
	add_recipe(Recipe.new(9,5,[8,1]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
