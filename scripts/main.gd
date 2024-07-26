extends Node2D

var customer_scene = preload("res://scenes/customer.tscn")
var gameover_scene = preload("res://scenes/defeat.tscn") as PackedScene
@onready var victory: PackedScene

@onready var shop = $Shop
@onready var workstation = $Workstation
@onready var customer_spawn_timer = $CustomerSpawnTimer
@onready var day_timer = $DayTimer
@onready var day_timer_label = $Control/DayTimerLabel
@onready var order_goal_label = $Control/OrderGoalLabel
@onready var menu = $Menu


var current_day = 1
var order_goal
var orders_completed
var current_customer
var new_day

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_day()
	shop.visible = true
	workstation.visible = false
	
	
	# Start spawn timer for first customer
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if orders_completed >= order_goal:
		_finish_day()
	day_timer_label.text = "Time left: " + str(int(day_timer.time_left))
	order_goal_label.text = "Goal: " + str(orders_completed) + "/" + str(order_goal)
	

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
	current_customer.customerOrderComplete.connect(_customer_order_complete)
	current_customer.customerOrderWrong.connect(_customer_order_wrong)
	current_customer.add_to_group("Customer")
	shop.add_child(current_customer)


func _customer_order_timeout():
	current_customer.queue_free()
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()

func _customer_order_complete():
	orders_completed += 1

func _customer_order_wrong():
	day_timer.wait_time = day_timer.time_left - 3
	day_timer.start()

func _on_potion_updated(updated_potion):
	if current_customer != null:
		if updated_potion.base.name == current_customer.order:
			current_customer.check_order(updated_potion)

func _start_day():
	order_goal = 2 + current_day
	orders_completed = 0
	day_timer.wait_time = 61
	day_timer.start()

func _finish_day():
	get_tree().paused = true
	var popup_instance = victory.instantiate()
	add_child(popup_instance)
	popup_instance.on_continue_callback = Callable(self, "_on_continue")
	
func _on_continue():
	get_tree().paused = false 
	order_goal += 1
	current_day += 1
	_start_day()
	

func _on_day_timer_timeout():
	get_tree().change_scene_to_packed(gameover_scene)

	
	

	
	
	
