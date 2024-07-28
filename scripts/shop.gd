extends Node2D

signal shopButtonPressed
signal potionSubmitted

#@onready var customer = $Customer
@onready var potion = $Potion
@onready var tooltip_label = $TooltipLabel
@onready var day_1_tooltip_arrow = $Day1TooltipArrow


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

func show_tooltip(string):
	tooltip_label.text = string

func show_day_1_tooltip_arrow(show_arrow: bool):
	day_1_tooltip_arrow.visible = show_arrow
