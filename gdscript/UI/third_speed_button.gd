extends Button

func _ready() -> void:
	pressed.connect(TimeManager._on_third_speed_selectd)
	pressed.connect(Selector._on_button_pressed)
