class_name School extends GovermentBuilding

func _on_level_set(value:int):
	level_change.emit(value)
