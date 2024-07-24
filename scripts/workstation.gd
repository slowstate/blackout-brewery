extends Node2D

@onready var potion = $Potion

signal potionUpdated(updatedPotion)

signal workstationButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	potionUpdated.emit(potion)
	workstationButtonPressed.emit()


func _on_bottle_bottle_clicked():
	potion.bottle = Recipes.bottle.added

func _on_green_potion_base_potion_base_clicked():
	potion.base = Recipes.bases.green


func _on_potion_potion_clicked():
	potion._clear_potion()
