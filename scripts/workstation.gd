extends Node2D

@onready var potion = $Potion
@onready var lamp = $Lamp
@onready var lamp_tooltip_label = $LampTooltipLabel
@onready var lamp_tooltip_timer = $LampTooltipTimer

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


func _on_shop_potion_submitted():
	potion._clear_potion()
	
func show_lamp(show: bool):
	lamp.visible = show

func reset_lamp_position():
	lamp.position = Vector2(500, 200)

func show_lamp_tooltip():
	lamp_tooltip_label.visible = true
	lamp_tooltip_timer.wait_time = 10
	lamp_tooltip_timer.start()


func _on_lamp_tooltip_timer_timeout():
	lamp_tooltip_label.visible = false
