class_name TextileMill extends FactoryBuilding
 
func _init() -> void:
	inventory = {"leather": 0, "clothes": 0}
	commodities_per_level = 5
	input_efficency = 2
	product = "clothes"
	production_input = "leather"
