class_name Journal
extends PanelContainer

@export var phrase_scene: PackedScene

@onready var container: VBoxContainer = %Container

func _ready() -> void:
	var test := CharacterResource.new()
	test.name = "иванов и. и."
	var phrases: PackedStringArray = [
		"Ничего не вижу, требуется подкрепление!",
		"Кажется, это что-то неприятное...",
		"Боже, оно живое! Отступаем!"
	]
	for i in range(3):
		var phrase := phrases[i]
		add_person_prhase(test, phrase)
		await get_tree().create_timer(1.5).timeout

func clear() -> void:
	for child in container.get_children():
		child.queue_free()

func add_person_prhase(person: CharacterResource, phrase: String) -> void:
	var instance := phrase_scene.instantiate() as PersonMessage
	container.add_child(instance)
	instance.person_name = person.name
	instance.description = "[неизвестный]"
	instance.phrase = phrase
	instance.smooth_appear()
