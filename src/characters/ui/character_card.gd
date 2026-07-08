class_name CharacterCard
extends PanelContainer

signal pressed(card: CharacterCard)

@export var data: CharacterResource

@onready var name_label: Label = %"Name Label"
@onready var portrait_texture: TextureRect = %"Portrait Texture"
@onready var button: Button = %Button

func _ready() -> void:
	button.pressed.connect(pressed.emit.bind(self))

func initialize(new_data: CharacterResource) -> void:
	data = new_data
	portrait_texture.texture = new_data.portrait
	name_label.text = new_data.name
