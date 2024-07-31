extends Node2D

var customer_scene = preload("res://scenes/customer.tscn")



@onready var start = $Start
@onready var victory = $Victory
@onready var defeat = $Defeat
@onready var shop = $Shop
@onready var workstation = $Workstation
@onready var customer_spawn_timer = $CustomerSpawnTimer
@onready var day_timer = $DayTimer
@onready var day_timer_label = $UI/DayTimerLabel
@onready var order_goal_label = $UI/OrderGoalLabel
@onready var ui = $UI


const DAY_LENGTH:int = 121

# Tooltip strings for Shop
const DAY_1_TOOLTIP: String = "Your first customer!\nBrew up their order in your Workstation."
const CUSTOMER_ORDER_TIMEOUT_TOOLTIP: String = "Customers won't wait forever,\ncomplete their order before they leave!"
const CUSTOMER_ORDER_WRONG_TOOLTIP: String = "You gave the wrong order!\nGiving the wrong order will decrease your time left."

# Tooltip strings for Workstation
const BREWING_TOOLTIP: String = "Your recipe list shows you how to brew each potion,\ntry brewing the customer's order."
const LAMP_TOOLTIP: String = "Oh no!\nWhat happened to the lights?!\nYou'll have to make use of your trusty lamp.\nTry dragging the lamp to continue brewing..."

var all_scenes = []

var current_day = 1
var order_goal
var orders_completed
var current_customer
var new_day

var customer_order_timeout_tooltip_shown:bool = false
var customer_order_wrong_tooltip_shown:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	all_scenes = [
		$Start,
		$Victory,
		$Defeat,
		$Shop,
		$Workstation
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !day_timer.is_stopped():
		if orders_completed >= order_goal:
			_finish_day()
		day_timer_label.text = "Time left: " + str(int(day_timer.time_left))
		order_goal_label.text = "Goal: " + str(orders_completed) + "/" + str(order_goal)
	

func _on_shop_shop_button_pressed():
	_change_scene(workstation)


func _on_workstation_workstation_button_pressed():
	_change_scene(shop)


func _on_customer_spawn_timer_timeout():
	if current_customer != null:
		AudioPlayer.play_FX(AudioPlayer.door_fx)
		current_customer.queue_free()
	
	current_customer = customer_scene.instantiate()
	current_customer.customerOrderTimeout.connect(_customer_order_timeout)
	current_customer.customerOrderComplete.connect(_customer_order_complete)
	current_customer.customerOrderWrong.connect(_customer_order_wrong)
	current_customer.add_to_group("Customer")
	shop.add_child(current_customer)
	if current_day == 1:
		shop.show_tooltip(DAY_1_TOOLTIP)
		shop.show_day_1_tooltip_arrow(true)
	if current_day <= 2: current_customer.set_timeout(DAY_LENGTH)


func _customer_order_timeout(orderCompleted):
	if !customer_order_timeout_tooltip_shown && !orderCompleted:
		shop.show_tooltip(CUSTOMER_ORDER_TIMEOUT_TOOLTIP)
		customer_order_timeout_tooltip_shown = true
	if current_customer != null: current_customer.queue_free()
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()

func _customer_order_complete():
	shop.show_tooltip("")
	orders_completed += 1

func _customer_order_wrong():
	if !customer_order_wrong_tooltip_shown:
		shop.show_tooltip(CUSTOMER_ORDER_WRONG_TOOLTIP)
		customer_order_wrong_tooltip_shown = true
	day_timer.wait_time = day_timer.time_left - 3
	day_timer.start()

func _on_potion_updated(updated_potion):
	if current_customer != null:
		if updated_potion.base.name == current_customer.order:
			current_customer.check_order(updated_potion)

func _start_day():
	if current_day == 1:
		workstation.show_lamp(false)
		workstation.show_tooltip(BREWING_TOOLTIP)
	elif current_day == 2:
		workstation.show_tooltip(LAMP_TOOLTIP)
		workstation.show_lamp(true)
	else:
		workstation.show_tooltip("")

	
	shop.show_tooltip("")
	shop.show_day_1_tooltip_arrow(false)
	workstation.reset_lamp_position()
	order_goal = 0 + current_day
	orders_completed = 0
	day_timer.wait_time = DAY_LENGTH
	day_timer.start()
	# Start spawn timer for first customer
	customer_spawn_timer.wait_time = randi_range(3, 5)
	customer_spawn_timer.start()


func _finish_day():
	if current_customer != null: current_customer.queue_free()
	day_timer.stop()
	_change_scene(victory)


func _on_day_timer_timeout():
	_change_scene(defeat)


func _change_scene(new_scene):
	for scene in all_scenes:
		if scene == new_scene:
			scene.visible = true
		else:
			scene.visible = false
	
	if new_scene == all_scenes[0]: ui.visible = false
	if new_scene == all_scenes[1]: ui.visible = false
	if new_scene == all_scenes[2]: ui.visible = false
	if new_scene == all_scenes[3]: ui.visible = true
	if new_scene == all_scenes[4]:
		ui.visible = true


func _on_start_start_pressed():
	_change_scene(shop)
	AudioPlayer.play_music_level(AudioPlayer.shop_music)
	_start_day()


func _on_defeat_reset_pressed():
	current_day = 1
	_change_scene(shop)
	_start_day()


func _on_victory_continue_pressed():
	current_day += 1
	_change_scene(shop)
	_start_day()
