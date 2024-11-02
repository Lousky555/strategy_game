class_name Country extends Node2D

@export var growth_multiplier: float = 0.0001
@export var qualifications: float 

func _monthly_update() -> void:
	for province: Node2D in get_children():
		if !(province is Wasteland or province is Sea):
			province.population += floor(province.population * growth_multiplier)

func _ready() -> void:
	TimeManager.longer_tick.connect(_monthly_update)
