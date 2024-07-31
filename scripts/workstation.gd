extends Node2D

@onready var potion = $Potion
@onready var lamp = $Lamp
@onready var tooltip_label = $TooltipLabel

signal potionUpdated(updatedPotion)

signal workstationButtonPressed


func _on_button_pressed():
	potionUpdated.emit(potion)
	workstationButtonPressed.emit()


func _on_bottle_bottle_clicked():
	potion.bottle = Recipes.bottle.added

func _on_green_potion_base_potion_base_clicked():
	potion.base = Recipes.bases.green

func _on_purple_potion_base_potion_base_clicked():
	potion.base = Recipes.bases.purple

func _on_red_potion_base_potion_base_clicked():
	potion.base = Recipes.bases.red

func _on_galberry_potion_ingredient_clicked():
	potion.ingredient = Recipes.ingredients.galberry

func _on_envy_potion_ingredient_clicked():
	potion.ingredient = Recipes.ingredients.envy

func _on_azureleaf_potion_ingredient_clicked():
	potion.ingredient = Recipes.ingredients.azureleaf

func _on_potion_potion_clicked():
	potion._clear_potion()

func _on_shop_potion_submitted():
	potion._clear_potion()
	
func show_lamp(show: bool):
	lamp.visible = show

func reset_lamp_position():
	lamp.position = Vector2(500, 200)

func show_tooltip(string):
	tooltip_label.text = string

