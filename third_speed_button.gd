extends Button

func _ready() -> void:
	pressed.connect(TimeManager._on_third_speed_selectd)
