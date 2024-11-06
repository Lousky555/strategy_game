extends TabContainer

var mouse_inside:bool = false

func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select") and !mouse_inside:
		current_tab = -1
