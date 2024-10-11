class_name Building extends Node

var population_per_level: int = 0
var market: Market
var money: int
var inventory: Dictionary

@export var level: int 

signal make_demand(me: Variant, commodity: String, amount: int)
signal make_supply(me: Variant, commodity: String, amount: int)

func _make_inventory():
	pass

func _on_tick():
	pass

func _work():
	pass

func _ready() -> void:
	market = get_parent().get_parent().get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	
	_make_inventory()
	
	TimeManager.tick.connect(_on_tick)
