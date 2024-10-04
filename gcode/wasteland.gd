class_name Wasteland extends Province

func _make_area(polygons, color:String) -> void:
	province_area = Province_Area.new()
	province_area.setup()
	
	for polygon in polygons:
		var graphical_polygon:Polygon2D = Polygon2D.new()
		graphical_polygon.polygon = polygon
		graphical_polygon.color = Color(color)
		add_child(graphical_polygon)
		graphical_polygons.append(graphical_polygon)
