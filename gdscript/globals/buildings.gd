extends Node

var dict:Dictionary = {
	"ArmsFactory":ArmsFactory,
	"Building":Building,
	"CoalMine":CoalMine,
	"ElectronicsFactory":ElectronicsFactory,
	"Farm":Farm,
	"FoodFactory":FoodFactory,
	"FurnitureFactory":FurnitureFactory,
	"GovermentConstruction":GovermentConstruction,
	"LumberMill":LumberMill,
	"MetalMine":MetalMine,
	"Pasture":Pasture,
	"School":School,
	"SteelMill":SteelMill,
	"TextileMill":TextileMill
}

func get_building_from_geop_data(data:String):
	if data.contains("-"):
		data = data.replace("-","_")
		data = data.to_pascal_case()
	if data.contains("_"):
		data = data.to_pascal_case()
	return dict[data]
