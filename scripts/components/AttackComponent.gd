extends Node3D
class_name AttackComponent

var attack_presets: Array[AttackPreset]
var is_attacking: bool = false

func _ready() -> void:
	attack_presets.append(AttackPreset.instantiate_preset(
		get_parent(),
		"Forward",
		Enums.AttackStyles.FORWARD,
		100,
		4))
	attack_presets.append(AttackPreset.instantiate_preset(
		get_parent(),
		"Fireball",
		Enums.AttackStyles.FIREBALL,
		200,
		6))
	attack_presets.append(AttackPreset.instantiate_preset(
		get_parent(),
		"Heal",
		Enums.AttackStyles.HEAL,
		200,
		5))
	attack_presets.append(AttackPreset.instantiate_preset(
		get_parent(),
		"Heal",
		Enums.AttackStyles.MULTIPLE_HEAL,
		100,
		8))
	for preset in attack_presets:
		add_child(preset)

func do_attack(targets: Array[Node3D], attack_style: Enums.AttackStyles, damage: int):
	if (is_attacking):
		return
	is_attacking = true
	for preset in attack_presets:
		if attack_style == preset.style:
			await preset.trigger_attack(targets)
			break
	print_debug("attack is done")
	is_attacking = false
