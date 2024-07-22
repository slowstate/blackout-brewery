extends Node2D

var customer_scene = preload("res://scenes/customer.tscn")

@onready var shop = $Shop
@onready var workstation = $Workstation

var current_customer

# Called when the node enters the scene tree for the first time.
func _ready():
	shop.visible = true
	workstation.visible = false

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
	var new_customer = customer_scene.instantiate()
	shop.add_child(new_customer)
