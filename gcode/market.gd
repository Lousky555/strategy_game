class_name Market extends Node

var commodities: Dictionary

func _ready() -> void:
	var data = FileSystem.import_file("res://geop_data/commodities.txt")
	
	for com_name in data:
		var new_commodity = Commodity.new()
		new_commodity.comodity_name = com_name
		new_commodity.prize = int(data[com_name]["prize"])
		
		commodities.get_or_add(com_name, new_commodity)
	
