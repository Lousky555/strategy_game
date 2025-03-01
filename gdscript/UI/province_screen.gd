extends PanelContainer

@onready var name_label = $ProvinceUI/ProvinceInfo/name
@onready var owner_label = $ProvinceUI/ProvinceInfo/OwnerBox/Owner
@onready var terrain_label = $ProvinceUI/ProvinceInfo/TerrainBox/Terrain
@onready var population_label = $ProvinceUI/ProvinceInfo/PopulationBox/Population
@onready var buildings_container = $ProvinceUI/ProvinceInfo/Buildings
@onready var builder_ui = $ProvinceUI/BuilderUICont/BuilderUI
@onready var army_ui = $ArmyUI
@onready var province_ui = $ProvinceUI
@onready var builder_ui_cont = $ProvinceUI/BuilderUICont

var current_province:Node2D
var current_army:Army

func _ready() -> void:
	Player.army_selected.connect(_on_army_selected)
	Player.province_update.connect(_on_province_update)
	Player.everything_unselected.connect(_on_all_deselected)
	TimeManager.tick.connect(_on_tick)
	construct_construction_ui()
	army_ui.visible = false
	province_ui.visible = false
	

func construct_building_ui(province:Node2D):
	buildings_container.add_child(UiMake.make_label("Type"))
	buildings_container.add_child(UiMake.make_label("Level"))
	buildings_container.add_child(UiMake.make_label("Money"))
	
	for child:Node in province.get_children():
		if child is Area2D or child is Polygon2D:
			continue
		
		buildings_container.add_child(UiMake.make_label(child.name))
		buildings_container.add_child(UiMake.make_label(str(child.level)))
		buildings_container.add_child(UiMake.make_label(str(round(child.money))))
	

func construct_construction_ui():
	for building:String in Buildings.dict:
		var button = UiMake.make_bulding_button(UiMake.pascal_to_normal(building) \
		, Buildings.get_building(building))
		button.building_button_pressed.connect(_on_building_button_pressed)
		button.building_button_pressed.connect(Player._on_button_pressed)
		builder_ui.add_child(button)

func _on_province_update(province:Node2D):
	
	for child:Node in buildings_container.get_children():
		child.queue_free()
	
	if province != current_province:
		name_label.text = province.name
		if province is not Sea:
			owner_label.text = province.get_parent().name
			if province is Plains:
				terrain_label.text = "Plains"
			elif province is Hills:
				terrain_label.text = "Hills"
			else:
				terrain_label.text = "Mountains"
		else:
			owner_label.text = "None"
			terrain_label.text = "Sea"
			population_label.text = "0"
		
		builder_ui_cont.visible = false
	
	if province is not Sea:
		construct_building_ui(province)
		population_label.text = str(province.population)
	
	current_province = province
	
	province_ui.visible = true
	army_ui.visible = false 
	

func _on_building_button_pressed(building):
	current_province._build_building(building, true)
	builder_ui_cont.visible = false

func _on_army_selected(army:Army):
	for child in army_ui.get_children():
		child.queue_free()
	
	army_ui.add_child(UiMake.make_label(army.name))
	for unit in army.units:
		var hbox = HBoxContainer.new()
		army_ui.add_child(hbox)
		hbox.add_child(UiMake.make_label("Unit " + str(army.units.find(unit) + 1)))
		hbox.add_child(UiMake.make_label(str(unit.equipment)))
	
	army_ui.visible = true
	province_ui.visible = false

func _on_all_deselected():
	province_ui.visible = false
	army_ui.visible = false

func _on_build_buildings_button_pressed() -> void:
	builder_ui_cont.visible = true

func _on_tick(): #updatuje UI každý tick
	if province_ui.visible:
		_on_province_update(current_province)
	elif army_ui.visible:
		_on_army_selected(current_army)
