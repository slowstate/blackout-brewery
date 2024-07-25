extends Node2D

signal shopButtonPressed

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
	print("updatedPotion: " + str(potion.sprite_2d.texture) + "| properties: bottle[" + str(potion.bottle) + "] base[" + str(potion.base) + "] ingredient[" + "]")


func _on_potion_potion_clicked():
	#get_tree().get_first_node_in_group("Customer")
	print("submit potion")

