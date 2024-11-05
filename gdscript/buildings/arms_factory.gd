class_name ArmsFactory extends FactoryBuilding
 
#write a ton 
func _init() -> void:
	inventory = {"arms": 0, "electronics": 0, "metal": 0, "food":0, "clothes":0, "furniture":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "arms"
	production_input = "leather"
	
