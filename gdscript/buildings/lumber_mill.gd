class_name LumberMill extends RootBuilding
 
func _init() -> void:
	inventory = {"wood": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 10
	product = "wood"
	population_per_level = 600
