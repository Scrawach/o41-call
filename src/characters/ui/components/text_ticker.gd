class_name TextTicker
extends Control

@export_multiline var text: String:
	set(new_text):
		text = new_text
		if not is_node_ready():
			await ready
		label_1.text = new_text
		label_2.text = new_text
		
		text_width = label_1.size.x
		label_1.position.x = spacing
		label_2.position.x = label_1.position.x + text_width + spacing

@export var speed: float = 50.0
@export var spacing: float = 10

@onready var label_1: Label = $Label1
@onready var label_2: Label = $Label2

var text_width: float

func _physics_process(delta: float) -> void:
	label_1.position.x -= speed * delta
	label_2.position.x -= speed * delta
	
	if -label_1.position.x > text_width:
		label_1.position = label_2.position + Vector2(text_width + spacing, 0)
	
	if -label_2.position.x > text_width:
		label_2.position = label_1.position + Vector2(text_width + spacing, 0)
