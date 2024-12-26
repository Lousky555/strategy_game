class_name MoverOrder extends Node

var start:Vector2
var end:Vector2
var lenght
var progress:int
var unit:MilitaryUnit

signal change_postion

func _init(astart:Vector2, aend:Vector2) -> void:
	start = astart
	end = aend
	
	var line = Line2D.new()
	line.add_point(start)
	line.add_point(end)
	
	lenght = start.direction_to(end)

func _ready() -> void:
	TimeManager.tick.connect(_on_tick)
	unit = get_parent()

func _on_tick():
	pass
