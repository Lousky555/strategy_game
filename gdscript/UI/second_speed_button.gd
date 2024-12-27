extends Button

func _ready() -> void:
	pressed.connect(TimeManager._on_second_speed_selected)
	pressed.connect(Selector._on_button_pressed)
