class_name AutoFillCharactersContainer
extends HBoxContainer

@export var data: Array[CharacterResource]:
	set(new_data):
		data = new_data
		_sync_visual_with_data()

@export var character_card_scene: PackedScene

func _ready() -> void:
	_sync_visual_with_data()

func _sync_visual_with_data() -> void:
	for child in get_children():
		child.queue_free()
	
	if not character_card_scene:
		return
	
	for item in data:
		var instance := character_card_scene.instantiate() as CharacterCard
		add_child(instance)
		instance.initialize(item)
