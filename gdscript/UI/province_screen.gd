extends PanelContainer

@onready var name_label = $ProvinceInfo/name
@onready var owner_label = $ProvinceInfo/OwnerBox/Owner
@onready var terrain_label = $ProvinceInfo/TerrainBox/Terrain
@onready var population_label = $ProvinceInfo/PopulationBox/Population

func _on_province_selected(province:Node2D):
	name_label.text = province.name
	if province is not Sea:
		owner_label.text = province.get_parent().name
		if province is Plains:
			terrain_label.text = "Plains"
		elif province is Hills:
			terrain_label.text = "Hills"
		else:
			terrain_label.text = "Mountains"
		population_label.text = str(province.population)
	else:
		owner_label.text = "None"
		terrain_label.text = "Sea"
		population_label.text = "0"
	
	visible = true

func  _on_province_deselected(province_name:String):
	if name_label.text == province_name: 
		visible = false
