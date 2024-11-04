extends Timer

@export var speed:int = 3: set = _set_speed
var tick_counter:int = 0
const  LONGER_TICK_LENGHT = 3

signal tick
signal longer_tick

func _on_pause_and_play_action_triggered(unpaused:bool):
	if unpaused:
		start()
	else:
		stop()

func _on_first_speed_selected():
	speed = 1
	print("changed speed to 1")

func _on_second_speed_selected():
	speed = 2
	print("changed speed to 2")

func _on_third_speed_selectd():
	speed = 3
	print("changed speed to 3")

func _on_timeout() -> void:
	tick_counter += 1
	tick.emit()
	
	if tick_counter == LONGER_TICK_LENGHT:
		longer_tick.emit()
		tick_counter = 0

func _set_speed(value) -> void:
	wait_time = value
	speed = value

func _ready() -> void:
	wait_time = speed 
	timeout.connect(_on_timeout)
	start()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_and_play"):
		if is_stopped():
			start()
			print("unpaused")
		else:
			print("paused ")
			stop()
