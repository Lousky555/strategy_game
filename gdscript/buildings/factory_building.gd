class_name FactoryBuilding extends Building

var product:String
var commodities_per_level:int
var input_efficency:float
var production_input:String

func _on_tick() -> void:
	if(money > 0):
		property_tax_pay.emit(self)
		buy_needs(money/2)
		make_demand.emit(self, production_input, (money / market.get_commodity(production_input).prize))
	_work()
	make_supply.emit(self, product, inventory[product])

func _work() -> void:
	if inventory[production_input] >= level * commodities_per_level * input_efficency * efficency:
		inventory[product] += level * commodities_per_level * efficency
		inventory[production_input] -= level * commodities_per_level * input_efficency * efficency
	elif  inventory[production_input] > 0:
		inventory[product] = inventory[production_input] / input_efficency * efficency
		inventory[production_input] = 0
	else:
		return
