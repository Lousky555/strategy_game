class_name GovermentConstruction extends Construction

signal get_state_money(me:Node)

func _ready() -> void:
	country = get_parent().get_parent()
	market = country.get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	property_tax_pay.connect(country._on_property_tax_pay)
	get_state_money.connect(country._on_building_demands_money)
	TimeManager.tick.connect(_on_tick)

func _on_tick() -> void:
	get_state_money.emit(self)
	if money > 0:
		buy_needs(money/2)
		if !inventory["steel"] >= (1 - progress) * 100 * difficulty:
			make_demand.emit(self, "steel", ((money / 2) / market.get_commodity("steel").prize))
		if !inventory["wood"] >= (1 - progress) * 100 * difficulty:
			make_demand.emit(self, "wood", (money / market.get_commodity("wood").prize))
	_work()
	if progress >= 1:
		if expansion:
			building.level += 1
			queue_free()
		else:
			var instance = building.new()
			instance.level = 1
			instance.name = str(building)
			get_parent().add_child(instance)
			queue_free()
