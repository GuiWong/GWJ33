extends Crafter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_recipe(Recipe.new(6,1,[0,0]))
	add_recipe(Recipe.new(15,1,[11,11,11]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
