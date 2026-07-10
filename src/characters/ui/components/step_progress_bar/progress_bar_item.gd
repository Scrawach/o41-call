@tool
class_name ProgressBarItem
extends PanelContainer

@onready var value: ColorRect = $Value
@onready var borders: PanelContainer = $Borders

func set_value(is_active: bool) -> void:
	value.visible = is_active
