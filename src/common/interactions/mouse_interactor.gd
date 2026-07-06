class_name MouseInteractor
extends Node3D

const RAY_LENGTH := 100

signal clicked(area: InteractionArea3D)

@export var camera: Camera3D
@export_flags_3d_physics var target_layer: int
@export var collide_with_areas: bool = true
@export var collide_with_bodies: bool

var previous_hover: InteractionArea3D

func make_cast() -> Dictionary:
	var mouse_position := get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_position)
	var to = from + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	var space := get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = target_layer
	query.collide_with_areas = collide_with_areas
	query.collide_with_bodies = collide_with_bodies
	return space.intersect_ray(query)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and previous_hover:
		previous_hover.click()
		clicked.emit(previous_hover)

func _physics_process(_delta: float) -> void:
	var area := try_interact()
	if area == null and previous_hover:
		previous_hover.unhover()
		previous_hover = null
	
	if area == null:
		return
	
	if previous_hover:
		previous_hover.unhover()
	previous_hover = area
	previous_hover.hover()

func try_interact() -> InteractionArea3D:
	var result := make_cast()
	if result.is_empty():
		return null
	var collider = result["collider"]
	return collider
