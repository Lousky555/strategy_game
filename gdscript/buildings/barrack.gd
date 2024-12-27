class_name Barrack extends GovermentBuilding

var unit_scene = preload("res://scenes/military_unit.tscn")

var equipment:int
var equipment_multiplier:float = 0.5
var unit:MilitaryUnit 

signal equipment_change(value:int)

func _init() -> void:
	inventory = {"crop": 0, "food":0, "clothes":0, "furniture":0, "electronics":0, "arms": 0}

func _on_tick():
	get_state_money.emit(self)
	buy_needs(money/2)
	make_demand.emit(self, "arms", money / market.get_commodity("arms").prize)
	_work()

func _work():
	if inventory["arms"] >= level * equipment_multiplier:
		inventory["arms"] -= level * equipment_multiplier
		change_equipment(100)
	elif  inventory["arms"] > 0:
		change_equipment((inventory["arms"]/(level*equipment_multiplier)) * 100)
	else:
		change_equipment(0)

func change_equipment(value:int) -> void:
	if value > 100 and value < 0:
		printerr("equipment cant be this value:" + str(value))
		get_tree().quit()
	if equipment == value:
		return
	else: 
		equipment = value
		equipment_change.emit(value)

func _on_war_started():
	equipment_multiplier = 2

func _on_war_ended():
	equipment_multiplier = 0.5

func _ready() -> void:
	country = get_parent().get_parent()
	market = country.get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	level_change.connect(country._on_school_level_change)
	get_state_money.connect(country._on_building_demands_money)
	TimeManager.tick.connect(_on_tick)
	country.war_started.connect(_on_war_started)
	country.war_ended.connect(_on_war_ended)
	
	unit = unit_scene.instantiate()
	country.add_child(unit)
	unit.global_position = get_parent().center
	unit.province = get_parent()
