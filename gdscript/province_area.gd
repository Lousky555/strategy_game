class_name Province_Area extends Area2D

@export var mouse_inside: bool = false

func setup() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	input_pickable = true

func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false
