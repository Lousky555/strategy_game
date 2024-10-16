extends Node2D

@onready var province_map = $province_map

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
	var data:Dictionary = FileSystem.import_file("res://geop_data/provinces.txt") 
	
	for color:String in data:
		var map:Image = province_map.texture.get_image()
		var province_bitmap:BitMap = get_province_bitmap(map, Color(color))
		var polygons:Array[PackedVector2Array] = province_bitmap.opaque_to_polygons(Rect2(Vector2(), province_bitmap.get_size()))
		
		var province:Variant
		match data[color]["terrain"]:
			"hills":
				province = Hills.new()
				province.population = data[color]["population"]
			"mountains":
				province = Mountain.new()
				province.population = data[color]["population"]
			"plains":
				province = Plains.new()
				province.population = data[color]["population"]
			"water":
				province = Sea.new()
			"wasteland":
				province = Wasteland.new()
		
		info[data[color]["country"]]["reference"].add_child(province)
		province.name = data[color]["name"]
		province._make_area(polygons, info[data[color]["country"]]["color"])
		if province is PopulatedProvince:
			province._make_buildings(data[color]["buildings"])

func load_countries(info:Dictionary) -> Dictionary:
	var data:Dictionary = FileSystem.import_file("res://geop_data/countries.txt")
	var info_for_provinces:Dictionary = {}
	
	for tag:String in data:
		var new_country:Country = Country.new()
		new_country.name = data[tag]["name"]
		new_country.qualifications = data[tag]["qualifications"]
		for market:Market in info:
			if tag in info[market]:
				market.add_child(new_country)
		info_for_provinces.get_or_add(tag,{"reference":new_country,"color":data[tag]["color"]})
	
	return info_for_provinces

func load_markets() -> Dictionary:
	var data:Dictionary = FileSystem.import_file("res://geop_data/markets.txt")
	var info_for_countries: Dictionary = Dictionary()
	
	for market_name: String in data:
		var new_market: Market = Market.new()
		new_market.name = market_name
		info_for_countries.get_or_add(new_market,data[market_name])
		add_child(new_market)
	
	return info_for_countries

func _ready() -> void:
	var info_for_countries = load_markets()
	var info_for_provinces = load_countries(info_for_countries)
	load_provinces(info_for_provinces)
	
	province_map.visible = false
