extends Control

signal continuePressed

func _on_continue_button_pressed():
	continuePressed.emit()

