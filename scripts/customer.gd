extends Node2D

signal customerOrderTimeout
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	# create random purchase order
	# random dialogue "Hi, I want [purchase order]"
	set_timeout()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	customerOrderTimeout.emit()


func set_timeout():
	timer.wait_time = randi_range(5, 10)
	timer.start()
