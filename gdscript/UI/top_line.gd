extends TabContainer

var mouse_inside:bool = false

@onready var country_ui:VBoxContainer = $Country 

func _ready() -> void:
	current_tab = -1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		current_tab = -1
