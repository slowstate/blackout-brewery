extends Control

signal startPressed

func _ready():
	pass

func _on_start_button_pressed():
	startPressed.emit()
