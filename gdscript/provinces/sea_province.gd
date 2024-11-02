class_name Sea extends Province

func _make_area(polygons, _color:String) -> void:
	province_area = Province_Area.new()
	province_area.setup()
	
	for polygon in polygons:
		var province_polygon:CollisionPolygon2D = CollisionPolygon2D.new()
		province_polygon.polygon = polygon
		add_child(province_area)
		province_area.add_child(province_polygon)
