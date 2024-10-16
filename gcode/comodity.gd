class_name Commodity extends Node

@export var comodity_name: String
@export var prize: float
@export var supply: float
@export var demand: float

var current_amount: float = 0

func buy(amount: float) -> float:
	if (current_amount - amount) > 0:
		current_amount -= amount
		demand += amount
		return amount * prize
	else:
		return 0

func sell(amount: float) -> float:
	if current_amount < 100:
		current_amount += amount
		supply += amount
		return amount * prize
	else:
		return 0

func _on_longer_tick() -> void:
	if supply == 0:
		prize = 100 * prize 
		return
	
	prize = prize * (demand/supply)
	supply = 0 
	demand = 0

func _ready() -> void:
	TimeManager.longer_tick.connect(_on_longer_tick)
