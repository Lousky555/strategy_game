class_name GovermentBuilding extends Building

signal level_change(value:int)
signal get_state_money(me:Node)

func _ready() -> void:
	country = get_parent().get_parent()
	market = country.get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	level_change.connect(country._on_school_level_change)
	get_state_money.connect(country._on_building_demands_money)
	TimeManager.tick.connect(_on_tick)
