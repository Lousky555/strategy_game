class_name Building extends Node

var population_per_level: int = 1000
var market: Market
var money: float = 20
var inventory: Dictionary
var needs:Array[String] = ["food","clothes","furniture","electronics"]
var country: Country
var employees:int = 0 
var hapiness:int = 100
var efficency:float = 1

signal property_tax_pay(building:Node)
signal hire_employees(building:Node)

@export var level: int : set = _on_level_set

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

func _on_level_set(value):
	hire_employees.emit(self)
	level = value

func _process(delta: float) -> void:
	if money == NAN:
		money = 0

func buy_needs(money_availible:float) -> void:
	var needs_bought = 0
	for need:String in needs:
		if money_availible > market.get_commodity(need).prize * (1 + country.consuption_tax_rate) * level:
			needs_bought += 1
			make_demand.emit(self, need, 1 * level, true) 
			money_availible -= money_availible - market.get_commodity(need).prize \
			* (1 + country.consuption_tax_rate)
		else:
			continue
	
	hapiness = (needs_bought / needs.size()) * 100

func _on_longer_tick():
	hire_employees.emit(self)
	
	efficency = 0.2 + 0.4 * (employees / (population_per_level * level)) + 0.4 * (hapiness / 100)

func _ready() -> void:
	country = get_parent().get_parent()
	market = country.get_parent()
	
	make_supply.connect(market._on_make_supply)
	make_demand.connect(market._on_make_demand)
	property_tax_pay.connect(country._on_property_tax_pay)
	TimeManager.tick.connect(_on_tick)
	TimeManager.longer_tick.connect(_on_longer_tick)
	hire_employees.emit(self)
