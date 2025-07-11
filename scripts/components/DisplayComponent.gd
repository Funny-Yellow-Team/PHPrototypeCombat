extends Node3D
class_name DisplayComponent

@export var main_asset: Node3D
@export var stats_display: PackedScene

func display_stat(amount: int, type: Enums.StatTypes):
	if (stats_display == null):
		return
	var instance = stats_display.instantiate()
	if (instance is not StatsDisplay):
		instance.queue_free()
		return
	var stats_display_instance: StatsDisplay = instance
	add_child(stats_display_instance)
	stats_display_instance.global_position = global_position
	stats_display_instance.trigger_stat_display(amount, type)
