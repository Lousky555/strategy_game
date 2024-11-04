class_name FoodFactory extends Building
 
var commodities_per_level = 5
var input_efficency = 2

func _init() -> void:
	inventory = {"crop": 0, "food": 0}

func _on_tick() -> void:
	if(money > 0):
		make_demand.emit(self, "crop", (money / market.get_commodity("crop").prize))
	_work()
	make_supply.emit(self, "food", inventory["food"])
	

func _work() -> void:
	if inventory["crop"] >= level * commodities_per_level * input_efficency:
		inventory["food"] = level * commodities_per_level
		inventory["crop"] -= level * commodities_per_level * input_efficency
	elif  inventory["crop"] > 0:
		inventory["food"] = inventory["crop"] / input_efficency
		inventory["crop"] = 0
	else:
		return
