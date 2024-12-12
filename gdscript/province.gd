class_name Province extends Node2D

@export var province_area:Province_Area
var selected:bool = false
@export var graphical_polygons:Array = Array()

signal province_selected(Province:Node2D)
signal province_deselected(province_name:String)

func _make_area(polygons, color:String) -> void:
	province_area = Province_Area.new()
	province_area.setup()
	
	for polygon in polygons:
		var province_polygon:CollisionPolygon2D = CollisionPolygon2D.new()
		var graphical_polygon:Polygon2D = Polygon2D.new()
		province_polygon.polygon = polygon
		graphical_polygon.polygon = polygon
		graphical_polygon.color = Color(color)
		add_child(province_area)
		province_area.add_child(province_polygon)
		add_child(graphical_polygon)
		graphical_polygons.append(graphical_polygon)

func _make_buildings(data:Dictionary) -> void:
	if name == "Czechia":
			var con = GovermentConstruction.new(false, Pasture)
			con.name = "Construction"
			add_child(con)
	for building_name in data:
		var new_building: Variant
		match building_name:
			"farm":
				new_building = Farm.new()
				new_building.name = "Farm"
			"arms-factory":
				new_building = ArmsFactory.new()
				new_building.name = "Arms Factory"
			"coal-mine":
				new_building = CoalMine.new()
				new_building.name = "Coal Mine"
			"electronics-factory":
				new_building = ElectronicsFactory.new()
				new_building.name = "Electronics Factory"
			"furniture-factory":
				new_building = FurnitureFactory.new()
				new_building.name = "Furniture Factory"
			"lumber-mill":
				new_building = LumberMill.new()
				new_building.name = "Lumber Mill"
			"food-factory":
				new_building = FoodFactory.new()
				new_building.name = "Food Factory"
			"metal-mine":
				new_building = MetalMine.new()
				new_building.name = "Metal Mine"
			"pasture":
				new_building = Pasture.new()
				new_building.name = "Pasture"
			"steel-mill":
				new_building = SteelMill.new()
				new_building.name = "Steel Mill"
			"textile-mill":
				new_building = TextileMill.new()
				new_building.name = "Textile Mill"
			"school":
				new_building = School.new()
				new_building.name = "School"
		
		new_building.level = data[building_name]
		add_child(new_building)
		
		

func select() -> void:
	if not selected:
		for polygon in graphical_polygons:
			polygon.color = polygon.color + Color(0.2, 0.2, 0.2)
		selected = true
		province_selected.emit(self)

func deselect() -> void:
	if selected:
		for polygon in graphical_polygons:
			polygon.color = polygon.color - Color(0.2, 0.2, 0.2) 
		selected = false
		province_deselected.emit(name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select") and province_area.mouse_inside:
		select()
	if event.is_action_pressed("esc") or (event.is_action_pressed("select") and !province_area.mouse_inside):
		deselect()
	
		
