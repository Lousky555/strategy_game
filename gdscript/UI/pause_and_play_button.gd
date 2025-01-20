extends TextureButton

func _ready() -> void:
	toggled.connect(TimeManager._on_pause_and_play_action_triggered)
	toggled.connect(Selector._on_button_pressed)
	button_pressed = true
