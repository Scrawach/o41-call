extends Node

func calculate_stats(type: int, power: int) -> void:
	print("CALCULATE FOR: %s - %s" % [type, power])
	await get_tree().create_timer(1.0).timeout
	print("DONE")
