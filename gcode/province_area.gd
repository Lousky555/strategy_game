class_name Province_Area extends Area2D

@export var mouse_inside: bool = false

func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false
