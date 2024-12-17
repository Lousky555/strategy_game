extends PanelContainer

@onready var name_label = $HBoxContainer/ProvinceInfo/name
@onready var owner_label = $HBoxContainer/ProvinceInfo/OwnerBox/Owner
@onready var terrain_label = $HBoxContainer/ProvinceInfo/TerrainBox/Terrain
@onready var population_label = $HBoxContainer/ProvinceInfo/PopulationBox/Population
@onready var buildings_container = $HBoxContainer/ProvinceInfo/Buildings
@onready var builder_ui = $HBoxContainer/BuilderUI

func construct_building_ui(province:Node2D):
	for child:Node in province.get_children():
		if child is Area2D or child is Polygon2D:
			continue
		
		var hbox = HBoxContainer.new()
		buildings_container.add_child(hbox)
		
		hbox.add_child(UiMake.make_label(child.name))
		hbox.add_child(UiMake.make_label("Level:"))
		hbox.add_child(UiMake.make_label(str(child.level)))
		hbox.add_child(UiMake.make_label("Money:"))
		hbox.add_child(UiMake.make_label(str(child.money)))
	

func construct_construction_ui(province:Node2D):
	for building:String in Buildings.dict:
		pass

func _on_province_selected(province:Node2D):
	for child:Node in buildings_container.get_children():
			child.queue_free()
	
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
	
	construct_building_ui(province)
	
	visible = true

func  _on_province_deselected(province_name:String):
	if name_label.text == province_name: 
		visible = false
