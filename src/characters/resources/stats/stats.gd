@tool
class_name Stats
extends Resource

@export var liqudation: int
@export var isolation: int
@export var expertise: int

func get_total_power() -> int:
	return liqudation + isolation + expertise

func intersect_percent(target: Stats) -> float:
	return float(target.get_total_power()) / get_total_power()

func smart_intersect_percent(target: Stats) -> float:
	var l := minf(float(liqudation) / target.liqudation, 1.0)
	var i := minf(float(isolation) / target.isolation, 1.0)
	var e := minf(float(expertise) / target.expertise, 1.0)
	return (l + i + e) / 3

static func random(max_value: int = 5) -> Stats:
	var stats := Stats.new()
	stats.liqudation = randi_range(1, max_value)
	stats.isolation = randi_range(1, max_value)
	stats.expertise = randi_range(1, max_value)
	return stats
