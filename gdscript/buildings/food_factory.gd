class_name FoodFactory extends FactoryBuilding
 
func _init() -> void:
	inventory = {"crop": 0, "food": 0}
	commodities_per_level = 5
	input_efficency = 2
	product = "food"
	production_input = "crop"
