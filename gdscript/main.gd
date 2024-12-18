extends Node2D

@onready var province_map = $province_map
@onready var province_screen = $CanvasLayer/AspectRatioContainer/ProvinceScreen

@onready var country_ui = $CanvasLayer/AspectRatioContainer/TopLine/Country
@onready var market_ui = $CanvasLayer/AspectRatioContainer/TopLine/Market
@onready var income_tax_ui = $CanvasLayer/AspectRatioContainer/TopLine/Country/IncomeTaxContainer
@onready var consuption_tax_ui = $CanvasLayer/AspectRatioContainer/TopLine/Country/ConsuptionTax
@onready var property_tax_ui = $CanvasLayer/AspectRatioContainer/TopLine/Country/PropertyTaxContainer

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
		var map:Image = Image.load_from_file("res://src/maps/High-Resolution-World-Map.png")
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
		
		if province is not Wasteland:
			province.province_selected.connect(province_screen._on_province_selected)
			province.province_deselected.connect(province_screen._on_province_deselected)
		
		info[data[color]["country"]]["reference"].add_child(province)
		if (province is not Wasteland) and (province is not Sea):
			info[data[color]["country"]]["reference"].population += province.population
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
		
		if tag == Player.country_tag:
			Player.country = new_country
	
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

func init_ui():
	country_ui.start()
	market_ui.start()
	income_tax_ui.start()
	consuption_tax_ui.start()
	property_tax_ui.start()

func _ready() -> void:
	var info_for_countries = load_markets()
	var info_for_provinces = load_countries(info_for_countries)
	load_provinces(info_for_provinces)
	
	province_map.visible = false
	init_ui()
