extends HBoxContainer

@onready var precentage_label = $ValueLabel

func start() -> void:
	precentage_label.text = str(Player.country.property_tax_rate)
	$PlusButton.pressed.connect(Player._on_button_pressed)
	$MinusButton2.pressed.connect(Player._on_button_pressed)

func _on_minus_button_pressed() -> void:
	var value = Player.country.change_property_tax_rate(-0.1)
	precentage_label.text = str(value)

func _on_plus_button_pressed() -> void:
	var value = Player.country.change_property_tax_rate(0.1)
	precentage_label.text = str(value) 
