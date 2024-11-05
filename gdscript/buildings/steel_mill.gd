class_name SteelMill extends FactoryBuilding
 
func _init() -> void:
	inventory = {"coal": 0, "metal": 0, "steel": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "food"
	production_input = "crop"
