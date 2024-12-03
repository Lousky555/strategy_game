class_name Building extends Node

var population_per_level: int = 0
var market: Market
var money: float = 20
var inventory: Dictionary
var needs:Array[String] = ["food","clothes","furniture","electronics"]
var country: Country


@export var level: int 

signal make_demand(me: Variant, commodity: String, amount: int)
signal make_supply(me: Variant, commodity: String, amount: int)

#Trida ze které dědí všechny budovy. Neinicializovat! řeší se zde jenom potřeby všechno ostaní má na strosti FactoryBuilding nebo
#RootBuilding

func _make_inventory() -> Dictionary:
	return Dictionary()

func _on_tick() -> void:
	pass

func _work() -> void:
	pass

func buy_needs(money_availible:float) -> void:
	for need:String in needs:
		if money_availible > market.get_commodity(need).prize * (1 + country.consuption_tax_rate):
			make_demand.emit(self, need, 1, true) 
			money_availible -= money_availible - market.get_commodity(need).prize * (1 + country.consuption_tax_rate)
		else:
			continue
	
	return

func _ready() -> void:
	country = get_parent().get_parent()
	market = country.get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	
	TimeManager.tick.connect(_on_tick)
