extends PanelContainer
class_name CharacterMenu

@export var character: Node3D
var allies: Array[Node3D]
var ennemies: Array[Node3D]
var atk_cmp: AttackComponent
var atk_buttons: Array[Button]
var selected_attack: AttackPreset
var trg_buttons: Array[Button]
var input_name: String
var get_selected_ennemy: Callable

var not_selected_style: StyleBox = preload("res://assets/UI/not_selected_character_style.tres")
var selected_style: StyleBox = preload("res://assets/UI/selected_character_style.tres")

func _ready() -> void:
	$CharacterContainer/TitleContainer/CharacterLabel.text = character.name
	$CharacterContainer/CharacterHealthBar.set_character(character)
	atk_cmp = ServiceContainer.get_attack_component(character)
	atk_cmp.attack_done.connect(on_attack_done)
	InputManager.input_mode_changed.connect(on_input_mode_changed)
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			var btn = AttackButton.instantiate_button(
				character,
				atk_cmp.attack_presets[i],
				InputManager.attack_inputs[i],
				input_name)
			btn.attack_button_pressed.connect(on_attack_button_pressed)
			$CharacterContainer/AttackContainer.add_child(btn.get_parent())
			atk_buttons.append(btn)

func _process(delta: float) -> void:
	if (Input.is_action_pressed(input_name)):
		add_theme_stylebox_override("panel", selected_style)
	else:
		add_theme_stylebox_override("panel", not_selected_style)
	set_attack_button_disabled(!atk_cmp.can_attack)
	if (atk_cmp.current_attack != null):
		$CharacterContainer/CooldownBar.value = atk_cmp.current_attack.cooldown_timer.time_left

func set_attack_button_disabled(disabled: bool):
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			atk_buttons[i].disabled = disabled

func on_attack_button_pressed(preset: AttackPreset):
	selected_attack = preset
	if (selected_attack.is_multi_target):
		if (selected_attack.target_type == Enums.TargetTypes.ALLY):
			launch_attack(allies)
		else:
			launch_attack(ennemies)
	else:
		if (selected_attack.target_type == Enums.TargetTypes.ALLY):
			launch_attack([character])
		else:
			launch_attack([get_selected_ennemy.call()])

func launch_attack(selected_targets: Array[Node3D]):
	atk_cmp.do_attack(selected_targets, selected_attack)

func on_attack_done():
	$CharacterContainer/CooldownBar.max_value = atk_cmp.current_attack.cooldown
	$CharacterContainer/CooldownBar.value = atk_cmp.current_attack.cooldown

func set_input_name(new_input_name: String):
	input_name = new_input_name
	$CharacterContainer/TitleContainer/CharacterInputTexture.texture = InputManager.texture[input_name]

func on_input_mode_changed():
	$CharacterContainer/TitleContainer/CharacterInputTexture.texture = InputManager.texture[input_name]
