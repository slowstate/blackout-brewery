extends Control

@onready var main = $main

func _on_continue_button_pressed():
	get_tree().paused = false 
	main.current_day += 1
	main._start_day()
	
