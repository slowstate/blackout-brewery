extends Control


@onready var reset_button = $TextureRect/Defeat/ResetButton as Button
@onready var start_again = preload("res://scenes/main.tscn") as PackedScene
@onready var game = $main

func _ready():
	reset_button.button_down.connect(_on_reset_button_button_down)
	
	

func _on_reset_button_button_down():
	print("Reset button pressed")
	get_tree().change_scene_to_packed(start_again)

