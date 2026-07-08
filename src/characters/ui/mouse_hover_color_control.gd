class_name MouseHoverColorControl
extends Node

@export var mouse_capture: Control
@export var target: Control
@export var hover_color: Color
@export var duration: float = 0.1
@export var enabled: bool = true

@export var ease_type: Tween.EaseType
@export var trans_type: Tween.TransitionType

var hover_tween: Tween
var base_color: Color

func _ready() -> void:
	base_color = target.modulate
	if enabled:
		enable()

func enable() -> void:
	mouse_capture.mouse_entered.connect(_on_mouse_entered)
	mouse_capture.mouse_exited.connect(_on_mouse_exited)
	enabled = true

func disable() -> void:
	mouse_capture.mouse_entered.disconnect(_on_mouse_entered)
	mouse_capture.mouse_exited.disconnect(_on_mouse_exited)
	enabled = false

func is_enabled() -> bool:
	return enabled

func _on_mouse_entered() -> void:
	_stop_if_needed()
	_create_coloring_tween(hover_color)

func _on_mouse_exited() -> void:
	_stop_if_needed()
	_create_coloring_tween(base_color)

func _create_coloring_tween(color: Color) -> Tween:
	hover_tween = create_tween()
	hover_tween.set_ease(ease_type)
	hover_tween.set_trans(trans_type)
	hover_tween.tween_property(target, "modulate", color, duration)
	return hover_tween

func _stop_if_needed() -> void:
	if hover_tween:
		hover_tween.custom_step(9999)
		hover_tween.kill()
	hover_tween = null
