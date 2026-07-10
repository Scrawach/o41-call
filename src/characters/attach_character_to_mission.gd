class_name AttachCharacterToMission
extends Node

@export var character_container: Control
@export var mission_setup: MissionCharacterSetup

func _ready() -> void:
	for child in character_container.get_children():
		if child is CharacterCard:
			child.pressed.connect(_on_card_pressed)

func _on_card_pressed(card: CharacterCard) -> void:
	mission_setup.append(card)
