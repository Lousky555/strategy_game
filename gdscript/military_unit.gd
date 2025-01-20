class_name MilitaryUnit extends Node

var equipment:int
var speed:int = 20 #jednotek za tick

func _on_equipment_change(value:int):
	equipment = value
