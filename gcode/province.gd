class_name Province extends Node

@onready var province_area = $province_area
var selected:bool = false
var graphical_polygons:Array = Array()

func make_area(polygons, color) -> void:
	for polygon in polygons:
		var province_polygon:CollisionPolygon2D = CollisionPolygon2D.new()
		var graphical_polygon:Polygon2D = Polygon2D.new()
		province_polygon.polygon = polygon
		graphical_polygon.polygon = polygon
		graphical_polygon.color = Color(color)
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") or (event.is_action_pressed("select") and !province_area.mouse_inside):
		deselect()
	if event.is_action("select") and province_area.mouse_inside:
		select()
