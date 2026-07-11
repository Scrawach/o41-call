@tool
class_name RadarChart
extends Control

@export var animation_duration: float = 0.4

@export var center_offset: Vector2
@export var radius_offset: float = 20.0

@export var max_value: float = 5.0:
	set(val):
		max_value = val
		queue_redraw()

@export var display_stat: Stats:
	set(new_stat):
		display_stat = new_stat
		_animate_stats()

@export var show_requirements: bool
@export var requirements_stat: Stats:
	set(new_stat):
		requirements_stat = new_stat
		_animate_stats()

@export var config := RadarChartResource.new()

@export_tool_button("update") var action = queue_redraw

const ANGLES = [deg_to_rad(-90), deg_to_rad(30), deg_to_rad(150)]

var _anim_kl: float = 0.0
var _anim_ki: float = 0.0
var _anim_ke: float = 0.0
var _tween: Tween

func _draw() -> void:
	var center = size / 2.0 - center_offset
	var max_radius = min(size.x, size.y) / 2.0 - radius_offset
	
	if max_radius <= 0:
		return
	
	_draw_axis(center, max_radius)
	
	if show_requirements:
		_draw_radar(center, Vector3(
			requirements_stat.liqudation, 
			requirements_stat.isolation,
			requirements_stat.expertise),
			max_radius, 
			config.requirements_fill_color, 
			config.requirements_line_color)
	
	_draw_radar(center, Vector3(
		_anim_kl, 
		_anim_ki, 
		_anim_ke), 
		max_radius, 
		config.fill_color, 
		config.line_color)

func _draw_axis(center: Vector2, radius: float) -> void:
	for i in range(1, int(max_value) + 1):
		var radius_step = radius * (float(i) / max_value)
		var grid_points = PackedVector2Array()
		
		for angle in ANGLES:
			grid_points.append(center + Vector2(cos(angle), sin(angle)) * radius_step)
		
		grid_points.append(grid_points[0])
		var color = config.axis_color if i == max_value else config.grid_color
		draw_polyline(grid_points, color, 1.0, true)

	for angle in ANGLES:
		var target_point = center + Vector2(cos(angle), sin(angle)) * radius
		draw_line(center, target_point, config.axis_color, 1.0, true)

func _draw_radar(center: Vector2, content: Vector3, max_radius: int, color: Color, contour_color: Color) -> void:
	if content.length() < 0.1:
		return
	
	var p_liquidation = center + Vector2(cos(ANGLES[0]), sin(ANGLES[0])) * (max_radius * min(content.x / max_value, 1.0))
	var p_isolation   = center + Vector2(cos(ANGLES[1]), sin(ANGLES[1])) * (max_radius * min(content.y / max_value, 1.0))
	var p_expertise   = center + Vector2(cos(ANGLES[2]), sin(ANGLES[2])) * (max_radius * min(content.z / max_value, 1.0))
	
	var stat_points = PackedVector2Array([p_liquidation, p_isolation, p_expertise])
	draw_polygon(stat_points, PackedColorArray([color]))
	
	var stat_contour = PackedVector2Array([p_liquidation, p_isolation, p_expertise, p_liquidation])
	draw_polyline(stat_contour, contour_color, 2.0, true)
	
	var values = [content.x, content.y, content.z]
	var i := 0
	for point in stat_points:
		draw_circle(point, 6, contour_color, true, -1.0, true)
		var value := str(roundi(values[i]))
		var char_font_size := 8
		draw_char(config.font, point - Vector2(2, -4), value, char_font_size, Color.BLACK)
		i += 1

func _animate_stats() -> void:
	if Engine.is_editor_hint():
		_anim_kl = display_stat.liqudation
		_anim_ki = display_stat.isolation
		_anim_ke = display_stat.expertise
		queue_redraw()
		return

	if _tween and _tween.is_running():
		_tween.custom_step(9999)
		_tween.kill()

	_tween = create_tween().set_parallel(true)
	_tween.set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "_anim_kl", display_stat.liqudation, animation_duration)
	_tween.tween_property(self, "_anim_ki", display_stat.isolation, animation_duration)
	_tween.tween_property(self, "_anim_ke", display_stat.expertise, animation_duration)

func _physics_process(_delta: float) -> void:
	if _tween and _tween.is_running():
		queue_redraw()

func update_requirements(stats: Stats) -> void:
	requirements_stat = stats

func update_stats(stat: Stats) -> void:
	display_stat = stat
