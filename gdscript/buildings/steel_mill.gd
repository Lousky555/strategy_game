class_name SteelMill extends FactoryBuilding
 
func _init() -> void:
	inventory = {"coal": 0, "metal": 0, "steel": 0}
	commodities_per_level = 5
	input_efficency = 2
	product = "food"
	production_input = "crop"
