class_name FoodFactory extends FactoryBuilding
 
func _init() -> void:
	inventory = {"crop": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 5
	input_efficency = 1.5
	product = "food"
	production_input = "crop"
	needs.erase(product)
	population_per_level = 700
