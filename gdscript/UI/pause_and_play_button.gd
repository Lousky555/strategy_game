extends TextureButton

func _ready() -> void:
	toggled.connect(TimeManager._on_pause_and_play_action_triggered)
	button_pressed = true
