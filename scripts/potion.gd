extends Node2D

var bottle_sprite = preload("res://assets/sprites/bottles/BigBottle/Bottle.png")
var green_potion_base_sprite = preload("res://assets/sprites/bottles/BigBottle/Solid/6.png")
var red_potion_base_sprite = preload("res://assets/sprites/bottles/BigBottle/Solid/3.png")
var purple_potion_base_sprite = preload("res://assets/sprites/bottles/BigBottle/Solid/7.png")
var azureleaf_sprite = preload("res://assets/sprites/bottles/BigBottle/Gradient/4.png")
var galberry_sprite = preload("res://assets/sprites/bottles/BigBottle/Gradient/11.png")
var envy_sprite = preload("res://assets/sprites/bottles/BigBottle/Gradient/14.png")

@onready var bottle_sprite_2d = $BottleSprite2D
@onready var solid_sprite_2d = $SolidSprite2D
@onready var gradient_sprite_2d = $GradientSprite2D

signal potionClicked

@export var bottle = Recipes.bottle.none :
	get: return bottle
	set(val):
		bottle = val
		_potion_updated()

@export var base = Recipes.bases.none :
	get: return base
	set(val):
		if bottle == Recipes.bottle.added:
			base = val
			_potion_updated()

@export var ingredient = Recipes.ingredients.none :
	get: return ingredient
	set(val):
		if bottle == Recipes.bottle.added && base != Recipes.bases.none:
			ingredient = val
			_potion_updated()


func _potion_updated():
	if bottle == Recipes.bottle.added:
		bottle_sprite_2d.texture = bottle_sprite
		if base == Recipes.bases.none && ingredient == Recipes.ingredients.none:
			AudioPlayer.play_FX(AudioPlayer.empty_bottle_fx)
	else: bottle_sprite_2d.texture = null
	
	#Set potion base layer
	if base == Recipes.bases.green:
		solid_sprite_2d.texture = green_potion_base_sprite
		AudioPlayer.play_FX(AudioPlayer.cauldron_pour_fx)
	elif base == Recipes.bases.red:
		solid_sprite_2d.texture = red_potion_base_sprite
		AudioPlayer.play_FX(AudioPlayer.cauldron_pour_fx)
	elif base == Recipes.bases.purple:
		solid_sprite_2d.texture = purple_potion_base_sprite
		AudioPlayer.play_FX(AudioPlayer.cauldron_pour_fx)
	else: solid_sprite_2d.texture = null
	
	#Set potion gradient layer
	if ingredient == Recipes.ingredients.envy:
		gradient_sprite_2d.texture = envy_sprite
		AudioPlayer.play_FX(AudioPlayer.ingrdient_add_fx)
	elif ingredient == Recipes.ingredients.galberry:
		gradient_sprite_2d.texture = galberry_sprite
		AudioPlayer.play_FX(AudioPlayer.ingrdient_add_fx)
	elif ingredient == Recipes.ingredients.azureleaf:
		gradient_sprite_2d.texture = azureleaf_sprite
		AudioPlayer.play_FX(AudioPlayer.ingrdient_add_fx)
	else: gradient_sprite_2d.texture = null

func _clear_potion():
	ingredient = Recipes.ingredients.none
	base = Recipes.bases.none
	bottle = Recipes.bottle.none
	_potion_updated()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("Left_Mouse_Button"):
		potionClicked.emit()
