class_name Country extends Node2D

@export var growth_multiplier: float = 0.0001
@export var qualifications: float 
@export var total_school_level: int = 0

@export var income_tax_rate:float = 0.15
@export var consuption_tax_rate:float = 0.15
@export var property_tax_rate:float = 1
@export var money:float = 100
@export var population:int = 0

var monthly_income_tax_surplus:float = 0
var monthly_consuption_tax_surplus:float = 0
var monthly_propetry_tax_surplus:float = 0 

func _monthly_update() -> void:
	for province: Node2D in get_children():
		if !(province is Wasteland or province is Sea):
			province.population += floor(province.population * growth_multiplier)
			population += floor(province.population * growth_multiplier)

func _ready() -> void:
	TimeManager.longer_tick.connect(_monthly_update)

func pay_income_tax(value:float):
	monthly_income_tax_surplus += value
	money += value

func pay_consuption_tax(value:float):
	monthly_consuption_tax_surplus += value
	money += value

func _on_property_tax_pay(building:Node):
		if property_tax_rate * building.level >=  building.money:
			money += building.money
			monthly_propetry_tax_surplus += building.money
			building.money = 0
			return
		else:
			money += property_tax_rate * building.level
			monthly_propetry_tax_surplus += building.money
			building.money -= property_tax_rate * building.level

func _on_school_level_change(value:int):
	total_school_level += value
