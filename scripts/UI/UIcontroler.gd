class_name MainMenu
extends Control

@onready var start_button = $TextureRect/Start/StartButton as Button
@onready var start_day = preload("res://scenes/main.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_day)
