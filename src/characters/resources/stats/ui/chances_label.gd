class_name ChancesLabel
extends PanelContainer

@export var current_value: float:
	set(new_value):
		current_value = new_value
		if not is_node_ready():
			await ready
		label.text = "%s%%" % snapped((current_value * 100), 1)

@onready var label: Label = %Label

var tween: Tween

func update(current: Stats, target: Stats) -> void:
	var percent := current.smart_intersect_percent(target)
	
	if tween:
		tween.custom_step(9999)
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "current_value", percent, percent)
