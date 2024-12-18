extends Node

func make_label(text:String) -> Label:
	var label = Label.new()
	label.text = text
	return label

func make_bulding_button(text:String, building:Variant) -> BuildingButton:
	var button = BuildingButton.new()
	button.building = building
	button.text = text
	return button
