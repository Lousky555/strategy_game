extends HBoxContainer

@onready var precentage_label = $Precentage

func start() -> void:
	precentage_label.text = str(Player.country.consuption_tax_rate * 100) + "%"
	$PlusButton.pressed.connect(Selector._on_button_pressed)
	$MinusButton.pressed.connect(Selector._on_button_pressed)

func _on_minus_button_pressed() -> void:
	var value = Player.country.change_consuption_tax_rate(-0.01)
	precentage_label.text = str(value * 100) + "%"

func _on_plus_button_pressed() -> void:
	var value = Player.country.change_consuption_tax_rate(0.01)
	precentage_label.text = str(value * 100) + "%"
