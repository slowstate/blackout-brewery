extends Node2D

signal customerOrderTimeout
signal customerOrderComplete
signal customerOrderWrong
var orderBase
var orderIngredient
var orderFulfilled = false

@onready var timer = $Timer
@onready var order_dialog = $Order/OrderDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_order()
	set_timeout()
	add_to_group("customers")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_order():
	orderBase = Recipes.bases.green
	#orderBase = randi_range(1, Recipes.bases.size()-1)
	orderIngredient = randi_range(0, Recipes.ingredients.size()-1)
	order_dialog.text = "Hi I want to buy " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient) + "!"
	
func check_order(potion):
	if potion.base == orderBase && potion.ingredient == orderIngredient:
		if !orderFulfilled:
			orderFulfilled = true
			order_dialog.text = "Thank you for the " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient) + "!"
			timer.wait_time = 4
			timer.start()
			customerOrderComplete.emit()
		if orderFulfilled:
			order_dialog.text = "Thanks for the donation!"
	else:
		order_dialog.text ="I'm still waiting for my " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient)
		customerOrderWrong.emit()

func _on_timer_timeout():
	customerOrderTimeout.emit()

func set_timeout():
	timer.wait_time = randi_range(5, 10)
	timer.start()
