@tool
class_name StepProgressBar
extends HBoxContainer

const PROGRESS_BAR_ITEM = preload("uid://w7h5tw71nj7q")

@export var value: int:
	set(new_value):
		value = new_value
		if not is_node_ready():
			await ready
		_update_value()
		
@export var max_value: int:
	set(new_value):
		max_value = new_value
		if not is_node_ready():
			await ready
		_update_max_value()

@export var item_size: Vector2:
	set(new_value):
		item_size = new_value
		if not is_node_ready():
			await ready
		_update_max_value()

var steps: Array[ProgressBarItem]

func _update_value() -> void:
	for i in max_value:
		var is_active := value >= (i + 1)
		steps[i].set_value(is_active)

func _update_max_value() -> void:
	for child in get_children():
		child.queue_free()
	steps.clear()
	for i in max_value:
		var item := PROGRESS_BAR_ITEM.instantiate() as ProgressBarItem
		item.custom_minimum_size = item_size
		add_child(item)
		steps.append(item)
	
	_update_value()
