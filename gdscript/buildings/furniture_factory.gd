class_name FurnitureFactory extends FactoryBuilding
 
func _init() -> void:
	inventory = {"wood": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "furniture"
	production_input = "wood"
	needs.erase(product)
