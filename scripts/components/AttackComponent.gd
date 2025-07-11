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

func do_attack(targets: Array[Node3D], attack_style: Enums.AttackStyles, damage: int):
	if (is_attacking):
		return
	is_attacking = true
	#TODO Use the attack preset
	is_attacking = false
