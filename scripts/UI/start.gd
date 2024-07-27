extends Control

signal startPressed


func _on_start_button_pressed():
	startPressed.emit()
