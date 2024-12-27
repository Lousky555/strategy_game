class_name MilitaryUnit extends Node2D

var equipment:int
var province:Province
var speed:int = 20 #jednotek za tick
var selected = false

signal unit_selected(unit:MilitaryUnit)

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

func _ready() -> void:
	unit_selected.connect(Selector._on_unit_selected)
	anim_state.travel("idling")

func start_moving(province:Node2D):
	var order = MoverOrder.new(global_position, province.center)
	order.change_position.connect(_on_change_position)
	order.movement_ends.connect(_movement_ended)
	add_child(order)
	
	var delta_vector = province.center - global_position
	var blen_pos = 0
	if delta_vector.x > 0:
		blen_pos = 1
	else: 
		blen_pos = -1
	anim_tree.set("parameters/dying/blend_position", blen_pos)
	anim_tree.set("parameters/running/blend_position", blen_pos)
	anim_tree.set("parameters/idling/blend_position", blen_pos)
	anim_state.travel("running")
	

func _on_change_position(pos:Vector2):
	global_position = pos

func _movement_ended():
	anim_state.travel("idling")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		unit_selected.emit(self)
