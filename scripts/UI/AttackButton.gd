extends Button
class_name AttackButton

signal attack_button_pressed(preset: AttackPreset)

var character: Node3D
var atk_cmp: AttackComponent
var atk_preset: AttackPreset
var cooldown_bar: ProgressBar
var input_tex: TextureRect
var input_name: String
var character_input_name: String

static func instantiate_button(
	character: Node3D,
	attack_preset: AttackPreset,
	input_name: String,
	character_input_name: String
) -> AttackButton:
	var container = HBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_BEGIN
	var texture = TextureRect.new()
	texture.custom_minimum_size = Vector2(48, 48)
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.texture = InputManager.texture[input_name]
	container.add_child(texture)
	var button = AttackButton.new()
	button.character = character
	button.text = attack_preset.name
	button.atk_preset = attack_preset
	button.atk_cmp = ServiceContainer.get_attack_component(character)
	button.input_name = input_name
	button.character_input_name = character_input_name
	button.input_tex = texture
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.pressed.connect(button.on_button_pressed)
	container.add_child(button)
	return button

func _ready() -> void:
	atk_cmp = ServiceContainer.get_attack_component(character)
	InputManager.input_mode_changed.connect(on_input_mode_changed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed(input_name) and Input.is_action_pressed(character_input_name):
		attack_button_pressed.emit(atk_preset)

func set_cooldown_bar(bar: ProgressBar):
	cooldown_bar = bar

func on_button_pressed():
	attack_button_pressed.emit(atk_preset)

func on_input_mode_changed():
	input_tex.texture = InputManager.texture[input_name]
