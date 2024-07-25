extends Node2D

var bottle_sprite = preload("res://assets/sprites/bottle.png")

@onready var sprite_2d = $Sprite2D

signal potionClicked

@export var bottle = Recipes.bottle.none :
	get: return bottle
	set(val):
		bottle = val
		_potion_updated()

@export var base = Recipes.bases.none :
	get: return base
	set(val):
		base = val
		_potion_updated()
		
@export var ingredient = Recipes.ingredients.none :
	get: return ingredient
	set(val):
		ingredient = val
		_potion_updated()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _potion_updated():
	if bottle == Recipes.bottle.added:
		sprite_2d.texture = bottle_sprite
	else: sprite_2d.texture = null

	
func _clear_potion():
	bottle = Recipes.bottle.none
	base = Recipes.bases.none
	ingredient = Recipes.ingredients.none
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("Left_Mouse_Button"):
		potionClicked.emit()
