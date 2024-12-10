extends HBoxContainer

@onready var value_label = $ValueLabel

func start():
	value_label.text = str(Player.country.property_tax_rate)

func _on_minus_button_pressed() -> void:
	var value = Player.country.property_tax_rate 
	var new_value = value - 0.1
	if (new_value) < 0:
		return
	else :
		Player.country.property_tax_rate = new_value
		value_label.text = str(new_value)

func _on_plus_button_pressed() -> void:
	var value = Player.country.property_tax_rate 
	var new_value = value + 0.1
	Player.country.property_tax_rate = new_value
	value_label.text = str(new_value)
