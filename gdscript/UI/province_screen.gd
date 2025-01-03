extends PanelContainer

@onready var name_label = $ProvinceUI/ProvinceInfo/name
@onready var owner_label = $ProvinceUI/ProvinceInfo/OwnerBox/Owner
@onready var terrain_label = $ProvinceUI/ProvinceInfo/TerrainBox/Terrain
@onready var population_label = $ProvinceUI/ProvinceInfo/PopulationBox/Population
@onready var buildings_container = $ProvinceUI/ProvinceInfo/Buildings
@onready var builder_ui = $ProvinceUI/VBoxContainer/BuilderUI
@onready var army_ui = $ArmyUI
@onready var province_ui = $ProvinceUI

var current_province:Node2D

func _ready() -> void:
	construct_construction_ui()
	visible = false

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
	

func construct_construction_ui():
	for building:String in Buildings.dict:
		var button = UiMake.make_bulding_button(building, Buildings.get_building(building))
		button.building_button_pressed.connect(_on_building_button_pressed)
		button.building_button_pressed.connect(Selector._on_button_pressed)
		builder_ui.add_child(button)

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
	current_province = province
	
	province_ui.visible = true
	army_ui.visible = false 

#nutno cele predelat
func  _on_province_deselected(province_name:String):
	if name_label.text == province_name: 
		visible = false
		pass

func _on_building_button_pressed(building):
	current_province._build_building(building, true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		visible = false

func _on_army_selected(army:Army):
	for child in army_ui.get_children():
		child.queue_free()
	
	army_ui.add_child(UiMake.make_label(army.name))
	for unit in army.units:
		var vbox = VBoxContainer.new()
		army_ui.add_child(vbox)
		vbox.add_child(UiMake.make_label("unit" + str(army.units.find(unit))))
		vbox.add_child(UiMake.make_label(str(unit.equipment)))
