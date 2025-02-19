class_name Relation extends Node

var country_a:Country 
var country_b:Country

var opinion:float = 0

func _ready() -> void:
	TimeManager.tick.connect(_on_tick)

func _on_tick() -> void:
	pass
