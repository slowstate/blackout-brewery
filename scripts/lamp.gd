extends Node2D

var draggable = false
var mouse_offset = Vector2(0, 0)

func _process(delta):
	if draggable:
		followMouse()

func followMouse():
	position = (get_global_mouse_position() + mouse_offset).clamp(-get_viewport().size/2, get_viewport().size/2)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			draggable = true
		else:
			draggable = false
