extends Node3D
class_name HealthBarHandler

@export var progress_bar: ProgressBar

func change_bar_value(value: int):
	if (progress_bar != null):
		progress_bar.value = value
