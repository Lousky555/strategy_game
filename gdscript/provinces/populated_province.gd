class_name PopulatedProvince extends Province

var population:int
var unemployed_population:int

func _make_buildings(data:Dictionary) -> void:
	for building_name:String in data:
		var new_building: Variant
		new_building = Buildings.get_building(building_name).new()
		new_building.level = data[building_name]
		new_building.name = building_name.replace("-"," ")
		new_building.hire_employees.connect(_on_hire_employees)
		add_child(new_building)

func _on_hire_employees(building:Node):
	if unemployed_population > building.population_per_level * building.level:
		building.employees += building.population_per_level * building.level
		unemployed_population -= building.population_per_level * building.level
	elif  unemployed_population > 0:
		building.employees = unemployed_population
		unemployed_population = 0
