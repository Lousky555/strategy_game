extends Node2D

@onready var province_map = $province_map
var province_scene = preload("res://scenes/province.tscn")

func import_file(filepath:String) -> Dictionary:
	var file:FileAccess = FileAccess.open(filepath, FileAccess.READ)
	if file != null:
		var dictionary:Dictionary = JSON.parse_string(file.get_as_text().replace("_", " "))
		if dictionary != null:
			return dictionary
		else:
			printerr("There is a mistake in some geopfile!")
			get_tree().quit()
			return Dictionary()
	else :
		printerr("Failed to open file: ", filepath)
		get_tree().quit()
		return Dictionary()

func get_province_bitmap(map:Image, color:Color) -> BitMap:
	var bitmap_image:Image = Image.create(map.get_width(), map.get_height(), false,Image.FORMAT_RGBA8)
	
	for y:int in range(map.get_height()):
		for x:int in range(map.get_width()):
			if map.get_pixel(x,y) == color:
				bitmap_image.set_pixel(x,y,"#ffffff")
		
	var province_bitmap:BitMap = BitMap.new()
	province_bitmap.create_from_image_alpha(bitmap_image)
	return province_bitmap

func load_provinces(info:Dictionary) -> void:
	var data:Dictionary = import_file("res://geop_data/provinces.txt") 
	
	for color:String in data:
		var map:Image = province_map.texture.get_image()
		var province_bitmap:BitMap = get_province_bitmap(map, Color(color))
		var polygons:Array[PackedVector2Array] = province_bitmap.opaque_to_polygons(Rect2(Vector2(), province_bitmap.get_size()))
		
		var province:Variant
		match data[color]["terrain"]:
			"hills":
				province = Hills.new()
			"mountains":
				province = Mountain.new()
			"plains":
				province = Plains.new()
			"water":
				province = Sea.new()
			"wasteland":
				province = Wasteland.new()
		
		info[data[color]["country"]]["reference"].add_child(province)
		province.name = data[color]["name"]
		province._make_area(polygons, info[data[color]["country"]]["color"])

func load_countries() -> Dictionary:
	var data:Dictionary = import_file("res://geop_data/countries.txt")
	var info_for_provinces:Dictionary = {}
	
	for tag:String in data:
		var new_country:Country = Country.new()
		new_country.name = data[tag]["name"]
		add_child(new_country)
		info_for_provinces.get_or_add(tag,{"reference":new_country,"color":data[tag]["color"]})
	
	return info_for_provinces

func _ready() -> void:
	var info = load_countries()
	load_provinces(info)
	
	province_map.visible = false
