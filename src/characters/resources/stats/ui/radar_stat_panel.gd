@tool
class_name RadarStatPanel
extends PanelContainer

@export var display_name: String:
	set(new_value):
		display_name = new_value
		if not is_node_ready():
			await ready
		label.text = display_name

@export var display_texture: Texture2D:
	set(new_value):
		display_texture = new_value
		if not is_node_ready():
			await ready
		texture_rect.texture = display_texture

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
