extends Resource
class_name BaseCondition

@export_group("Action")
@export var attack: AttackPresetTemplate
@export var target: BaseTarget
var attack_preset: AttackPreset
var character: Node3D

func _init() -> void:
	if (self.get_script() == preload("res://scripts/game/ai/BaseCondition.gd")):
		push_error("Cannot instantiate base condition directly!")

func initialize_condition(character_self: Node3D):
	character = character_self
	target.initialize_target(character)
	attack_preset = AttackPreset.instantiate_preset(
			character,
			attack.attack_name,
			attack.attack_style,
			attack.damage,
			attack.target_type,
			attack.is_multi_target,
			attack.cooldown)

func validate_condition() -> bool:
	return true
