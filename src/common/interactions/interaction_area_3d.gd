class_name InteractionArea3D
extends Area3D

const INTERACTION_LAYER: int = 1 << 4

signal hovered()
signal unhovered()
signal clicked()

@export var state: InteractionState

func _ready() -> void:
	monitoring = false
	monitorable = false
	collision_layer = INTERACTION_LAYER
	collision_mask = 0

func hover() -> void:
	hovered.emit()

func unhover() -> void:
	unhovered.emit()

func click() -> void:
	clicked.emit()

func get_interaction_state() -> InteractionState:
	return state

func set_active(is_enable: bool) -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = not is_enable
