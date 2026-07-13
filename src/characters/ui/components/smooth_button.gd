@tool
class_name SmoothButton
extends PanelContainer

signal pressed()

@export_multiline var text: String:
	set(value):
		text = value
		if not is_node_ready():
			await ready
		label.text = text

@export var aligment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_CENTER:
	set(value):
		aligment = value
		if not is_node_ready():
			await ready
		label.horizontal_alignment = aligment

@onready var label: Label = %Label
@onready var button: Button = %Button

func _ready() -> void:
	button.pressed.connect(pressed.emit)
