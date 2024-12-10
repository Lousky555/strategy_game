extends HBoxContainer

@onready var precentage_label = $Precentage

func start():
	precentage_label.text = str(Player.country.income_tax_rate * 100) + "%"

func _on_minus_button_pressed() -> void:
	var value = Player.country.income_tax_rate 
	var new_value = value - 0.01
	if (new_value) < 0:
		return
	else :
		Player.country.income_tax_rate = new_value
		precentage_label.text = str(new_value * 100) + "%"

func _on_plus_button_pressed() -> void:
	var value = Player.country.income_tax_rate 
	var new_value = value + 0.01
	if (new_value) > 1:
		return
	else :
		Player.country.income_tax_rate = new_value
		precentage_label.text = str(new_value * 100) + "%"
