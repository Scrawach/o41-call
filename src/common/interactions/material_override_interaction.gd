class_name MaterialOverrideInteraction
extends Node

@export var hover_material: StandardMaterial3D

@export var interaction: InteractionArea3D
@export var mesh: MeshInstance3D

func _ready() -> void:
	interaction.hovered.connect(_on_interaction_hovered)
	interaction.unhovered.connect(_on_interaction_unhovered)

func _on_interaction_hovered() -> void:
	mesh.material_overlay = hover_material

func _on_interaction_unhovered() -> void:
	mesh.material_overlay = null
