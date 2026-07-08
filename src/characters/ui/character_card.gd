class_name CharacterCard
extends PanelContainer

@export var data: CharacterResource

@onready var face_texture: TextureRect = %"Face Texture"
@onready var name_label: Label = %"Name Label"

func initialize(new_data: CharacterResource) -> void:
	data = new_data
	face_texture.texture = new_data.face
	name_label.text = new_data.name

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("clicked")
