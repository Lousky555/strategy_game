class_name ElectronicsFactory extends FactoryBuilding
 
func _init() -> void:
	inventory = {"metal": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "electronics"
	production_input = "metal"
	needs.erase(product)
	population_per_level = 1200
