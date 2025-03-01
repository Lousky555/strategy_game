class_name Province extends Node2D

@export var province_area:Province_Area
var selected:bool = false
var center:Vector2 
@export var graphical_polygons:Array = Array()

signal province_selected(Province:Node2D)
signal province_deselected(province_name:String)
signal moving_detected(province:Node2D)

func _make_area(polygons, color:String) -> void:
	province_area = Province_Area.new()
	province_area.setup()
	province_area.input_event.connect(_province_area_input)
	
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

func select() -> void:
	if not selected:
		for polygon in graphical_polygons:
			polygon.color = polygon.color + Color(0.2, 0.2, 0.2)
		selected = true

func deselect() -> void:
	if selected:
		for polygon in graphical_polygons:
			polygon.color = polygon.color - Color(0.2, 0.2, 0.2) 
		selected = false
		province_deselected.emit(name)
	
func _build_building(building:Variant, govermental:bool):
	for child in get_children():
		if child.get_script() == building:
			if govermental:
				var construction = GovermentConstruction.new(true, child)
				construction.name = (UiMake.pascal_to_normal(\
				Buildings.dict.find_key(building)) + " construction")
				add_child(construction)
				return
	if govermental:
		var construction = GovermentConstruction.new(false, building)
		construction.name = (UiMake.pascal_to_normal(\
		Buildings.dict.find_key(building)) + " construction")
		add_child(construction)

func _on_hire_employees(building:Node):
	pass

func _province_area_input(view: Viewport, event:InputEvent, child:int):
	if event.is_action_pressed("select"):
		province_selected.emit(self)
	
	if event.is_action_pressed("move"):
		moving_detected.emit(self)
