class_name School extends GovermentBuilding

func _init() -> void:
	inventory = {"crop": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	population_per_level = 100

func _on_level_set(value:int):
	hire_employees.emit(self)
	level_change.emit(value)
	level = value

func _on_tick():
	get_state_money.emit(self)
	buy_needs(money)
