class_name Farm extends Building
 
var commodities_per_level = 10

func _make_invetory():
	inventory.get_or_add("crop", 0)
	
func _on_tick():
	_work()
	make_supply.emit(self, "crop", inventory["crop"])

func _work():
	inventory["crop"] = commodities_per_level * level
