extends Control

@onready var radar_chart: RadarChart = $"Group RadarChart"
@onready var chances_label: ChancesLabel = $"Chances Label"

func _ready() -> void:
	while true:
		await get_tree().create_timer(1.0).timeout
		var random_stat := Stats.random()
		radar_chart.update_stats(random_stat)
		chances_label.update(random_stat, radar_chart.requirements_stat)
