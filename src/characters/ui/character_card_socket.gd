class_name CharacterCardSocket
extends PanelContainer

signal pressed(socket: CharacterCardSocket)

@onready var empty_socket: PanelContainer = %"Empty Socket"
@onready var occupied_socket: PanelContainer = %"Occupied Socket"

@onready var portrait: TextureRect = %Portrait
@onready var character_name: Label = %"Character Name"
@onready var button: Button = %Button

var card: CharacterCard

func _ready() -> void:
	button.pressed.connect(pressed.emit.bind(self))

func is_empty() -> bool:
	return card == null

func apply(target: CharacterCard) -> void:
	card = target
	var data = target.data
	portrait.texture = data.portrait
	empty_socket.hide()
	occupied_socket.show()
	character_name.text = data.name
	card.occupy()

func reset() -> void:
	if card:
		card.vacate()
	
	card = null
	portrait.texture = null
	occupied_socket.hide()
	empty_socket.show()
