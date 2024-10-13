class_name Building extends Node

var population_per_level: int = 0
var market: Market
var money: float = 20
var inventory: Dictionary

@export var level: int 

signal make_demand(me: Variant, commodity: String, amount: int)
signal make_supply(me: Variant, commodity: String, amount: int)

func _make_inventory() -> Dictionary:
	return Dictionary()

func _on_tick() -> void:
	pass

func _work() -> void:
	pass

func _ready() -> void:
	market = get_parent().get_parent().get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	
	TimeManager.tick.connect(_on_tick)
