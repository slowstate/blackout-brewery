extends Control

@export var on_continue_callback: Callable

func _on_continue_button_pressed():
	if on_continue_callback:
		on_continue_callback.call()
	queue_free()
	
