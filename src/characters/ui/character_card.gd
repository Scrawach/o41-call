class_name CharacterCard
extends PanelContainer

signal hovered(card: CharacterCard)
signal unhovered(card: CharacterCard)
signal pressed(card: CharacterCard)

@export var data: CharacterResource

@onready var name_label: Label = %"Name Label"
@onready var portrait_texture: TextureRect = %"Portrait Texture"
@onready var button: Button = %Button

@onready var hover_card_scale_control: MouseHoverScaleControl = $"Hover Card Scale Control"
@onready var hover_card_color_control: MouseHoverColorControl = $"Hover Card Color Control"
@onready var hover_portrait_color_control: MouseHoverColorControl = $"Hover Portrait Color Control"

func _ready() -> void:
	button.pressed.connect(pressed.emit.bind(self))
	button.mouse_entered.connect(hovered.emit.bind(self))
	button.mouse_exited.connect(unhovered.emit.bind(self))

func initialize(new_data: CharacterResource) -> void:
	data = new_data
	portrait_texture.texture = new_data.portrait
	name_label.text = new_data.name

func occupy() -> void:
	hover_card_color_control.disable()
	hover_card_scale_control.disable()
	hover_portrait_color_control.disable()
	button.disabled = true
	self.modulate.a = 0.5

func vacate() -> void:
	hover_card_color_control.enable()
	hover_card_scale_control.enable()
	hover_portrait_color_control.enable()
	button.disabled = false
	self.modulate.a = 1.0
