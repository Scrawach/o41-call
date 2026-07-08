class_name TextTicker
extends Control

@export_multiline var text: String:
	set(new_text):
		text = new_text
		if not is_node_ready():
			await ready
		label.text = new_text
	
@export var speed: float = 50.0

@onready var label: Label = $Label

func _physics_process(delta: float) -> void:
	label.position.x -= speed * delta
	if label.position.x < -label.size.x:
		label.position.x = size.x
