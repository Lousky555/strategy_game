class_name RootBuilding extends Building

var needs:Array
var product:String
var commodities_per_level:int

func _work():
	inventory[product] = commodities_per_level * level

func _on_tick() -> void:
	_work()
	make_supply.emit(self, product, inventory[product])
