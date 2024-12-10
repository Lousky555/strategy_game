class_name RootBuilding extends Building

var product:String
var commodities_per_level:int

func _work():
	inventory[product] = commodities_per_level * level

func _on_tick() -> void:
	buy_needs(money/2)
	_work()
	make_supply.emit(self, product, inventory[product])
