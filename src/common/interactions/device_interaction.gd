class_name DeviceInteraction
extends InteractionState

@export var desired_camera: Camera3D
@export var area: InteractionArea3D

var moving: Tween
var main_camera_local_transform: Transform3D

func enter() -> void:
	area.set_active(false)
	main_camera_local_transform = main_camera.transform
	smooth_camera_moving(main_camera, desired_camera.global_transform)

func exit() -> void:
	reset_main_camera(main_camera)
	area.set_active(true)

func is_busy() -> bool:
	return moving.is_running()

func smooth_camera_moving(target: Camera3D, target_transform: Transform3D) -> void:
	_kill_camera_moving_if_needed()
	moving = create_tween()
	moving.set_trans(Tween.TRANS_EXPO)
	moving.tween_property(target, "global_transform", target_transform, 0.3)

func reset_main_camera(target: Camera3D) -> void:
	_kill_camera_moving_if_needed()
	moving = create_tween()
	moving.tween_property(target, "transform", main_camera_local_transform, 0.3)

func _kill_camera_moving_if_needed() -> void:
	if moving:
		moving.custom_step(9999)
		moving.kill()
