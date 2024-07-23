extends Node2D

var customer_scene = preload("res://scenes/customer.tscn")

@onready var shop = $Shop
@onready var workstation = $Workstation
@onready var customer_spawn_timer = $CustomerSpawnTimer

var current_customer

# Called when the node enters the scene tree for the first time.
func _ready():
	shop.visible = true
	workstation.visible = false
	
	# Start spawn timer for first customer
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_shop_shop_button_pressed():
	shop.visible = false
	workstation.visible = true


func _on_workstation_workstation_button_pressed():
	shop.visible = true
	workstation.visible = false


func _on_customer_spawn_timer_timeout():
	if current_customer != null:
		current_customer.queue_free()
	current_customer = customer_scene.instantiate()
	current_customer.customerOrderTimeout.connect(_customer_order_timeout)
	shop.add_child(current_customer)


func _customer_order_timeout():
	current_customer.queue_free()
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()
