class_name Farm extends Building
 
var commodities_per_level = 10

func _init() -> void:
	inventory = {"crop": 0}
	
func _on_tick() -> void:
	_work()
	make_supply.emit(self, "crop", inventory["crop"])
	

func _work() -> void:
	inventory["crop"] = commodities_per_level * level
