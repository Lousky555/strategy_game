class_name Commodity extends Node

@export var comodity_name: String
@export var prize: float
@export var supply: float
@export var demand: float

var current_amount: float = 0

func buy(amount: float) -> float:
	demand += amount
	if (current_amount - amount) > 0:
		current_amount -= amount
		return amount * prize
	elif current_amount > 0:
		current_amount = 0
		return amount * prize
	else:
		return 0

func sell(amount: float) -> float:
	supply += amount
	if current_amount < 100 and prize > 0:
		current_amount += amount
		return amount * prize
	else:
		return 0

func _on_longer_tick() -> void:
	if supply == 0 and demand == 0:
		return
	elif supply == 0:
		prize = 100 * prize 
		return
	elif prize == 0:
		prize = 0.01
		return
	
	prize = prize * (demand/supply)
	supply = 0 
	demand = 0
	
func _ready() -> void:
	TimeManager.longer_tick.connect(_on_longer_tick)
