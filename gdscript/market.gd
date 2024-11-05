class_name Market extends Node

var commodities: Dictionary

func get_commodity(argument_name: String) -> Commodity:
	for i in commodities:
		if i == argument_name:
			return commodities[i]
		
	printerr("Cant find commodity")
	get_tree().quit()
	return Commodity.new()

func _on_make_demand(building: Variant, commodity_name: String, amount: float) -> void:
	var commodity = get_commodity(commodity_name)
	var money_spend = commodity.buy(amount)
	
	building.money -= money_spend
	if money_spend == 0:
		return
	building.inventory[commodity_name] +=  amount
	

func _on_make_supply(building: Variant, commodity_name: String, amount: float) -> void:
	var commodity = get_commodity(commodity_name)
	var money_gained = commodity.sell(amount)
	
	building.money += money_gained
	if money_gained == 0:
		return
	building.inventory[commodity_name] -= amount

func _ready() -> void:
	var data = FileSystem.import_file("res://geop_data/commodities.txt")
	
	for com_name in data:
		var new_commodity = Commodity.new()
		new_commodity.comodity_name = com_name
		new_commodity.prize = int(data[com_name]["prize"])
		
		commodities.get_or_add(com_name, new_commodity)
		OuterSpace.add_child(new_commodity)
	
