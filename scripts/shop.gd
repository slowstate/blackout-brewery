extends Node2D

signal shopButtonPressed
signal potionSubmitted

#@onready var customer = $Customer
@onready var potion = $Potion


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	shopButtonPressed.emit()


func _on_workstation_potion_updated(updatedPotion):
	potion.bottle = updatedPotion.bottle
	potion.base = updatedPotion.base
	potion.ingredient = updatedPotion.ingredient
	potion.sprite_2d.texture = updatedPotion.sprite_2d.texture

func _on_potion_potion_clicked():
	var customer = get_tree().get_first_node_in_group("Customer")
	if potion.bottle == Recipes.bottle.none || customer == null: return
	customer.check_order(potion)
	potion._clear_potion()
	potionSubmitted.emit()
