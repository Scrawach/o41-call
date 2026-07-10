class_name MissionCharacterSetup
extends VBoxContainer

@export var socket_scene: PackedScene

@onready var group_count: Label = $"HBoxContainer/Group Count"
@onready var socket_container: HBoxContainer = $"Socket Container"

var sockets: Array[CharacterCardSocket]

func _ready() -> void:
	initialize_sockets(4)

func initialize_sockets(count: int) -> void:
	for i in count:
		var instance := socket_scene.instantiate() as CharacterCardSocket
		socket_container.add_child(instance)
		sockets.append(instance)
		instance.pressed.connect(_on_socket_pressed)

func _on_socket_pressed(socket: CharacterCardSocket) -> void:
	socket.reset()
	update_group_label()

func get_occupied_count() -> int:
	var occupied := 0
	for socket in sockets:
		if not socket.is_empty():
			occupied += 1
	return occupied

func has_free_space() -> bool:
	return get_occupied_count() > 0

func append(character: CharacterCard) -> void:
	for socket in sockets:
		if socket.is_empty():
			socket.apply(character)
			break
	update_group_label()

func update_group_label() -> void:
	var total := sockets.size()
	group_count.text = "[%s/%s]" % [get_occupied_count(), total]
