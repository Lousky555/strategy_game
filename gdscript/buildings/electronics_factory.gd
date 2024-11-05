class_name ElectronicsFactory extends FactoryBuilding
 
func _init() -> void:
	inventory = {"metal": 0, "electronics": 0}
	commodities_per_level = 5
	input_efficency = 2
	product = "electronics"
	production_input = "metal"
