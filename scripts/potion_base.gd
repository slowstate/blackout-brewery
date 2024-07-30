extends Node2D

signal potionBaseClicked


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("Left_Mouse_Button"):
		potionBaseClicked.emit() 
