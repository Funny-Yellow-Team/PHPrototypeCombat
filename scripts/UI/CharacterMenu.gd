extends VBoxContainer
class_name CharacterMenu

@export var character: Node3D
@export var debug_target: Node3D
@export var is_focused_debug: bool
var atk_cmp: AttackComponent
var atk_buttons: Array[Button]

func _ready() -> void:
	$CharacterLabel.text = character.name
	$CharacterHealthBar.set_character(character)
	atk_cmp = ServiceContainer.get_attack_component(character)
	atk_cmp.attack_done.connect(on_attack_done)
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			var btn = AttackButton.instantiate_button(character, atk_cmp.attack_presets[i])
			btn.attack_button_pressed.connect(on_attack_button_pressed)
			$VBoxContainer.add_child(btn)
			atk_buttons.append(btn)
	#if is_focused_debug:
		#atk_buttons[0].grab_focus()

func _process(delta: float) -> void:
	set_attack_button_disabled(!atk_cmp.can_attack)
	if (atk_cmp.current_attack != null):
		$CooldownBar.value = atk_cmp.current_attack.cooldown_timer.time_left

func set_attack_button_disabled(disabled: bool):
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			atk_buttons[i].disabled = disabled

func on_attack_button_pressed(preset: AttackPreset):
	atk_cmp.do_attack([debug_target], preset)

func on_attack_done():
	$CooldownBar.max_value = atk_cmp.current_attack.cooldown
	$CooldownBar.value = atk_cmp.current_attack.cooldown
