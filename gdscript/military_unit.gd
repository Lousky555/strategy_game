class_name MilitaryUnit extends Node2D

var equipment:int
var province:Province
var speed:int = 20 #jednotek za tick

func start_moving(province:Province):
	var order = MoverOrder.new(global_position, province.center)
	order.change_postion.connect(_on_change_positon)

func _on_change_positon(pos:Vector2):
	global_position = pos
