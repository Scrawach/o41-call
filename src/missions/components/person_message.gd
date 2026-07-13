@tool
class_name PersonMessage
extends HBoxContainer

@export var person_name: String:
	set(value):
		person_name = value
		if not is_node_ready():
			await ready
		person_label.text = person_name

@export var description: String:
	set(value):
		description = value
		if not is_node_ready():
			await ready
		small_description.text = description

@export_multiline var phrase: String:
	set(value):
		phrase = value
		if not is_node_ready():
			await ready
		message_label.text = phrase
		
		if not Engine.is_editor_hint():
			start_writting(message_label)

@onready var person_label: Label = %"Person Label"
@onready var small_description: Label = %"Small Description"
@onready var message_label: Label = %"Message Label"

var writting_tween: Tween
var appear_tween: Tween

func start_writting(target: Label) -> void:
	if writting_tween:
		writting_tween.custom_step(9999)
		writting_tween.kill()
	
	writting_tween = create_tween()
	writting_tween.tween_property(target, "visible_ratio", 1.0, 1.0).from(0)

func smooth_appear() -> void:
	if appear_tween:
		appear_tween.custom_step(9999)
		appear_tween.kill()
	
	appear_tween = create_tween()
	appear_tween.tween_property(self, "modulate:a", 1.0, 0.5).from(0.0)
