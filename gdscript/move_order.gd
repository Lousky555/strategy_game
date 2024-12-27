class_name MoverOrder extends Node

var start:Vector2
var end:Vector2
var lenght
var progress:int = 0
var speed:int
var progress_per_tick:int 
var direction:Vector2

signal change_position(pos:Vector2)
signal movement_ends()

func _init(astart:Vector2, aend:Vector2) -> void:
	start = astart
	end = aend
	
	var line = Line2D.new()
	line.add_point(start)
	line.add_point(end)
	line.z_index = 3
	
	lenght = start.distance_to(end)
	direction = start.direction_to(end)

func _ready() -> void:
	TimeManager.tick.connect(_on_tick)
	speed = get_parent().speed
	progress_per_tick = (speed / lenght) * 100

func _on_tick():
	progress += progress_per_tick
	if progress < 100:
		change_position.emit(start + direction * speed)
	else:
		change_position.emit(end)
		movement_ends.emit()
		queue_free()
