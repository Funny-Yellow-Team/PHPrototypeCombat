extends ProgressBar
class_name CharacterHealthBar

@export var health_component: HealthComponent
var health_label: Label

func _ready() -> void:
	health_label = Label.new()
	health_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	health_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	health_label.add_theme_font_size_override("font_size", 12)
	health_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(health_label)

func _process(delta: float) -> void:
	value = health_component.current_health
	health_label.text = str(int(value))

func set_character(character: Node3D):
	health_component = ServiceContainer.get_health_component(character)
	max_value = health_component.base_health
