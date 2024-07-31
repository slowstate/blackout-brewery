extends Node2D

signal customerOrderTimeout(completed: bool)
signal customerOrderComplete
signal customerOrderWrong
var orderBase
var orderIngredient
var orderCompleted = false

var customer_blue = preload("res://assets/sprites/Customer/customer_Blue.png")
var customer_darkred = preload("res://assets/sprites/Customer/customer_darkred.png")
var customer_green = preload("res://assets/sprites/Customer/customer_green.png")
var customer_purple = preload("res://assets/sprites/Customer/customer_purple.png")
var customer_red = preload("res://assets/sprites/Customer/customer_red.png")
var customer_white = preload("res://assets/sprites/Customer/customer_white.png")

@onready var timer = $Timer
@onready var order_dialog = $Order/OrderDialog


var customer_sprites = [
	customer_white,
	customer_blue,
	customer_red,
	customer_green,
	customer_purple,
	customer_darkred]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	generate_order()
	set_timeout()
	random_sprite()
	add_to_group("customers")


func generate_order():
	orderBase = Recipes.bases.green
	#orderBase = randi_range(1, Recipes.bases.size()-1)
	orderIngredient = randi_range(0, Recipes.ingredients.size()-1)
	order_dialog.text = "Hi I want to buy " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient) + "!"
	
func check_order(potion):
	if potion.base == orderBase && potion.ingredient == orderIngredient:
		if !orderCompleted:
			orderCompleted = true
			order_dialog.text = "Thank you for the " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient) + "!"
			timer.wait_time = 4
			timer.start()
			customerOrderComplete.emit()
		elif orderCompleted:
			order_dialog.text = "Thanks for the donation!"
	else:
		order_dialog.text ="I'm still waiting for my " + Recipes.bases.find_key(orderBase) + " with " + Recipes.ingredients.find_key(orderIngredient)
		customerOrderWrong.emit()



func _on_timer_timeout():
	customerOrderTimeout.emit(orderCompleted)

func set_timeout(custom_wait_time:int = 20):
	timer.wait_time = custom_wait_time
	timer.start()
	
func random_sprite():
	var random_index = randi() % customer_sprites.size()
	var random_sprite = customer_sprites[random_index]
	var sprite_node = get_node("CustomerSprite")
	sprite_node.texture = random_sprite
