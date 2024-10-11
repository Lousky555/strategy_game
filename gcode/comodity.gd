class_name Commodity extends Node

@export var comodity_name: String
@export var prize: int
@export var supply: int
@export var demand: int

var current_amount: int = 0

func buy(amount: int) -> int:
	if (current_amount - amount) > 0:
		current_amount -= amount
		supply += amount
		return amount * prize
	else:
		return 0

func sell(amount: int) -> int:
	if current_amount < 100:
		current_amount += amount
		supply += amount
		return amount * prize
	else:
		return 0
