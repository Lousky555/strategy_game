class_name MilitaryUnit extends Node2D

var equipment:int
var province:Province
var speed:int = 20 #jednotek za tick

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

func start_moving(province:Province):
	var order = MoverOrder.new(global_position, province.center)
	order.change_postion.connect(_on_change_positon)
	order.movement_ends.connect(_movement_ended)
	
	var delta_vector = global_position - province.center
	anim_tree.set("parameters/dying/blend_position", delta_vector)
	anim_tree.set("parameters/running/blend_position", delta_vector)
	anim_tree.set("parameters/idling/blend_position", delta_vector)
	anim_state.travel("running")

func _on_change_positon(pos:Vector2):
	global_position = pos

func _movement_ended():
	anim_state.travel("idling")

func _ready() -> void:
	anim_state.travel("idling")
