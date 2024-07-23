extends Node2D

var bottle_sprite = preload("res://assets/sprites/bottle.png")

@onready var sprite_2d = $Sprite2D

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
	print("Potion updated: bottle[" + str(bottle) + "] base[" + str(base) + "] ingredient[" + "]")
	if bottle == Recipes.bottle.added:
		print("change potion sprite")
		sprite_2d.texture = bottle_sprite
	else: sprite_2d.texture = null

func _clear_potion():
	bottle = Recipes.bottle.none
	base = Recipes.bases.none
	ingredient = Recipes.ingredients.none
	

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("player_select"):
		_clear_potion()
