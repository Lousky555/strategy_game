extends Node

func make_label(text:String) -> Label:
	var label = Label.new()
	label.text = text
	return label

func make_button(text:String) -> Button:
	var button = Button.new()
	button.text = text
	return button
