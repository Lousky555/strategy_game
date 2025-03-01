extends Node

var dict:Dictionary = {
	"ArmsFactory":ArmsFactory,
	"CoalMine":CoalMine,
	"ElectronicsFactory":ElectronicsFactory,
	"Farm":Farm,
	"FoodFactory":FoodFactory,
	"FurnitureFactory":FurnitureFactory,
	"LumberMill":LumberMill,
	"MetalMine":MetalMine,
	"Pasture":Pasture,
	"School":School,
	"SteelMill":SteelMill,
	"TextileMill":TextileMill,
	"Barrack":Barrack
}

func get_building(data:String):
	data = data.to_pascal_case()
	if data.contains("-"):
		data = data.replace("-","_")
		data = data.to_pascal_case()
	if data.contains("_"):
		data = data.to_pascal_case()

	return dict[data]
