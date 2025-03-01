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

func pascal_to_normal(string:StringName) -> String:
	var formated_string = string.to_snake_case()
	formated_string = formated_string.replace("_"," ")
	formated_string = formated_string.replace("-"," ")
	formated_string[0] = formated_string[0].capitalize()
	return(formated_string)
