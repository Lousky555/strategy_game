class_name MoverOrder extends Node

var start:Vector2
var end:Vector2
var lenght
var progress:int = 0
var speed:int
var progress_per_tick:int 
var x_ratio:float
var y_ratio:float

signal change_postion(pos:Vector2)
signal movement_ends()

func _init(astart:Vector2, aend:Vector2) -> void:
	start = astart
	end = aend
	
	var line = Line2D.new()
	line.add_point(start)
	line.add_point(end)
	
	lenght = start.direction_to(end)

func _ready() -> void:
	TimeManager.tick.connect(_on_tick)
	speed = get_parent().speed
	progress_per_tick = (speed / lenght) * 100

func _on_tick():
	progress += progress_per_tick
	if progress < 100:
		change_postion.emit(Vector2(speed * x_ratio, speed * y_ratio))
	else:
		change_postion.emit(end)
		movement_ends.emit()
		queue_free()

func make_ratios():
	var vector:Vector2 = start - end
	var sum:int = abs(vector.x) + abs(vector.y)
	x_ratio = vector.x / sum
	y_ratio = vector.y / sum
