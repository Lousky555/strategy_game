extends Node

var selected_province:Node2D
var button_pressed:bool = false
var selected_unit:MilitaryUnit

func _on_button_pressed():
	button_pressed = true

func _on_province_selected(province:Node2D):
	if province == null:
		return
	if selected_province != null:
		selected_province.deselect()
	selected_province = province
	deselect_unit()

func _on_movement_order(province):
	#prepsat pro valku
	if Player.country == province.get_parent() and selected_unit != null \
	and selected_unit.state == selected_unit.IDLING:
		selected_unit.start_moving(province)
	
func _on_unit_selected(unit:MilitaryUnit):
	deselect_province()
	selected_unit = unit
	selected_unit.select()

func _input(event: InputEvent) -> void: 
	if event.is_action_pressed("esc"):
		deselect_province()
		deselect_unit()

func deselect_province():
	if selected_province != null:
		selected_province.deselect()
		selected_province = null

func deselect_unit():
	if selected_unit != null:
		selected_unit.deselect()
		selected_unit = null
