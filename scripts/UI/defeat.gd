extends Control

signal resetPressed

func _on_reset_button_pressed():
	resetPressed.emit()
