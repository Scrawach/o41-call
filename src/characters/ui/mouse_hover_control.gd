class_name MouseHoverScaleControl
extends Node

@export var mouse_capture: Control
@export var target: Control
@export var target_scale: float = 1.05
@export var duration: float = 0.05
@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType

var hover_tween: Tween

func _ready() -> void:
	enable()

func enable() -> void:
	mouse_capture.mouse_entered.connect(_on_mouse_entered)
	mouse_capture.mouse_exited.connect(_on_mouse_exited)

func disable() -> void:
	mouse_capture.mouse_entered.disconnect(_on_mouse_entered)
	mouse_capture.mouse_exited.disconnect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	_stop_if_needed()
	_create_scaling_tween(target_scale)

func _on_mouse_exited() -> void:
	_stop_if_needed()
	_create_scaling_tween(1.0)

func _create_scaling_tween(modifier: float) -> Tween:
	hover_tween = create_tween()
	hover_tween.set_ease(ease_type)
	hover_tween.set_trans(trans_type)
	hover_tween.tween_property(target, "scale", Vector2.ONE * modifier, duration)
	return hover_tween

func _stop_if_needed() -> void:
	if hover_tween:
		hover_tween.custom_step(9999)
		hover_tween.kill()
	hover_tween = null
