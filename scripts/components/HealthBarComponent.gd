extends Node3D
class_name HealthBarComponent

var health_component: HealthComponent
@export var health_bar_handler: HealthBarHandler

func _ready() -> void:
	health_component = ServiceContainer.get_health_component(get_parent())
	health_component.connect("health_changed", Callable(self, "on_health_changed"))
	if (health_bar_handler != null):
		health_bar_handler.progress_bar.max_value = health_component.base_health
		health_bar_handler.change_bar_value(health_component.current_health)

func on_health_changed(health: int):
	health_bar_handler.change_bar_value(health)
