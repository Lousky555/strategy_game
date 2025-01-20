class_name ArmsFactory extends FactoryBuilding

#Továrna na zbraně ,kod je podobný s SteelMill

func _init() -> void:
	inventory = {"arms": 0, "electronics": 0, "steel": 0, "food":0, "clothes":0, "furniture":0}
	commodities_per_level = 5
	input_efficency = 2
	product = "arms"

func _on_tick() -> void:
	if(money > 0):
		buy_needs(money/2)
		make_demand.emit(self, "steel", ((money / 2) / market.get_commodity("steel").prize))
		make_demand.emit(self, "electronics", (money / market.get_commodity("electronics").prize))
	_work()
	make_supply.emit(self, product, inventory[product])

func _work() -> void:
	if inventory["steel"] >= level * commodities_per_level * input_efficency * efficency and inventory["electronics"] >= level * commodities_per_level * input_efficency * efficency:
		inventory["arms"] = level * commodities_per_level * efficency
		inventory["steel"] -= level * commodities_per_level * input_efficency * efficency
		inventory["electronics"] -= level * commodities_per_level * input_efficency * efficency
	elif  inventory["steel"] > 0 and inventory["electronics"] > 0:
		if inventory["steel"] < inventory["electronics"]:
			inventory[product] = inventory["steel"] / input_efficency * efficency
			inventory["electronics"] -= inventory["steel"] * efficency
			inventory["steel"] = 0
		else:
			inventory[product] = inventory["electronics"] / input_efficency * efficency
			inventory["steel"] -= inventory["electronics"] * efficency
			inventory["electronics"] = 0
	else:
		return
