extends Node2D

signal customerOrderTimeout
var order = ""
var orderFulfilled = false

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_order()
	set_timeout()
	add_to_group("customers")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_order():
	var orders = []
	order = "Potion"
	get_node("Order/OrderDialog").text = "Hi I want to buy " + order + "!"
	
func check_order(potion):
	if potion.base.name == order:
		orderFulfilled = true
		get_node("Order").text = "Thank you for the " + order + "!"
		timer.stop()
		queue_free()
	else:
		get_node("Order").text = "I'm still waiting for my " + order

func _on_timer_timeout():
	customerOrderTimeout.emit()

func set_timeout():
	timer.wait_time = randi_range(5, 10)
	timer.start()
