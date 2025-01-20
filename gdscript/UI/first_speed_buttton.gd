extends Button


func _ready() -> void:
	pressed.connect(TimeManager._on_first_speed_selected)
	pressed.connect(Selector._on_button_pressed)
