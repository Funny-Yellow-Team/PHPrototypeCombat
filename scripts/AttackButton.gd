extends Button
class_name AttackButton

signal attack_button_pressed(preset: AttackPreset)

var character: Node3D
var atk_cmp: AttackComponent
var atk_preset: AttackPreset
var cooldown_bar: ProgressBar

static func instantiate_button(
	character: Node3D,
	attack_preset: AttackPreset
) -> AttackButton:
	var button = AttackButton.new()
	button.character = character
	button.text = attack_preset.name
	button.atk_preset = attack_preset
	button.atk_cmp = ServiceContainer.get_attack_component(character)
	button.pressed.connect(button.on_button_pressed)
	return button

func _ready() -> void:
	atk_cmp = ServiceContainer.get_attack_component(character)

func set_cooldown_bar(bar: ProgressBar):
	cooldown_bar = bar

func on_button_pressed():
	attack_button_pressed.emit(atk_preset)
