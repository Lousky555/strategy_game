class_name Province extends Node2D

@export var province_area:Province_Area
var selected:bool = false
@export var graphical_polygons:Array = Array()

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

func _on_tick():
	pass

func _on_longer_tick():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") or (event.is_action_pressed("select") and !province_area.mouse_inside):
		deselect()
	if event.is_action_pressed("select") and province_area.mouse_inside:
		select()

func _ready() -> void:
	TimeManager.longer_tick.connect(_on_longer_tick)
	TimeManager.tick.connect(_on_tick)
