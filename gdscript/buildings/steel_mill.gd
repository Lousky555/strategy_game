class_name SteelMill extends FactoryBuilding
 
func _init() -> void:
	inventory = {"coal": 0, "steel": 0, "metal": 0, "food":0, "clothes":0, "furniture":0, "electronics":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "steel"

func _on_tick() -> void:
	if(money > 0):
		buy_needs(money/2)
		make_demand.emit(self, "metal", ((money / 2) / market.get_commodity("metal").prize))
		make_demand.emit(self, "coal", (money / market.get_commodity("coal").prize))
	_work()
	make_supply.emit(self, product, inventory[product])

func _work() -> void:
	if inventory["metal"] >= level * commodities_per_level * input_efficency and inventory["coal"] >= level * commodities_per_level * input_efficency:
		inventory[product] += level * commodities_per_level
		inventory["metal"] -= level * commodities_per_level * input_efficency
		inventory["coal"] -= level * commodities_per_level * input_efficency
	elif  inventory["metal"] > 0 and inventory["coal"] > 0:
		if inventory["metal"] < inventory["coal"]:
			inventory[product] = inventory["metal"] / input_efficency
			inventory["coal"] -= inventory["metal"]
			inventory["metal"] = 0
		else:
			inventory[product] = inventory["coal"] / input_efficency
			inventory["metal"] -= inventory["coal"]
			inventory["coal"] = 0
	else:
		return
