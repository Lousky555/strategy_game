class_name Country extends Node2D

@export var growth_multiplier: float = 0.0001
@export var qualifications: float 
@export var total_school_level: int = 0

@export var income_tax_rate:float = 0.15
@export var consuption_tax_rate:float = 0.15
@export var property_tax_rate:float = 1
@export var money:float = 100:
	set (value):
		on_money_change.emit(value)
		money = value
@export var population:int = 0

signal on_money_change(value:float)
signal income_tax_sup_change(value:float)
signal consuption_tax_sup_change(value:float)
signal propery_tax_sup_change(value:float)

var monthly_income_tax_surplus:float = 0:
	set (value):
		income_tax_sup_change.emit(value)
		monthly_income_tax_surplus = value
var monthly_consuption_tax_surplus:float = 0:
	set (value):
		consuption_tax_sup_change.emit(value)
		monthly_consuption_tax_surplus = value
var monthly_propetry_tax_surplus:float = 0 :
	set (value):
		propery_tax_sup_change.emit(value)
		monthly_propetry_tax_surplus = value

func _monthly_update() -> void:
	for province: Node2D in get_children():
		if !(province is Wasteland or province is Sea):
			province.population += floor(province.population * growth_multiplier)
			population += floor(province.population * growth_multiplier)
		
		qualifications += (2500*total_school_level - population) / population
		
		monthly_consuption_tax_surplus = 0
		monthly_income_tax_surplus = 0
		monthly_propetry_tax_surplus = 0

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

func _on_building_demands_money(building:Node):
	if building is not GovermentConstruction:
		money -= building.level * 10
		building.money += building.level * 10
	else:
		money -= building.difficulty * building.effectivness
		building.money += building.difficulty * building.effectivness

func change_income_tax_rate(value:float) -> float:
	var new_value = income_tax_rate + value
	if new_value < 0 or new_value > 1:
		return income_tax_rate
	else :
		income_tax_rate = new_value
		return income_tax_rate

func change_property_tax_rate(value:float) -> float:
	var new_value = property_tax_rate + value
	if new_value < 0:
		return property_tax_rate
	else :
		property_tax_rate = new_value
		return property_tax_rate

func change_consuption_tax_rate(value:float) -> float:
	var new_value = consuption_tax_rate + value
	if new_value < 0 or new_value > 1:
		return consuption_tax_rate
	else :
		consuption_tax_rate = new_value
		return consuption_tax_rate
