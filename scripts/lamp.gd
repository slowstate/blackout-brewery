extends CharacterBody2D

var is_dragging = false
var offset: Vector2
var mouse_in = false

func _process(delta):
	if mouse_in:
		if Input.is_action_just_pressed("Left_Mouse_Button") and not is_dragging:
			offset = get_global_mouse_position() - global_position
			is_dragging = true
		
		if Input.is_action_pressed("Left_Mouse_Button") and is_dragging:
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("Left_Mouse_Button"):
			is_dragging = false

func _on_draggable_area_body_entered(body):
	if body == self:
		mouse_in = true
	


func _on_draggable_area_body_exited(body):
	if body == self:
		mouse_in = false
		is_dragging = false
