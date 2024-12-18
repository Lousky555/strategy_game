class_name BuildingButton extends Button

var building

signal building_button_pressed(building)

func _init() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	building_button_pressed.emit(building)
