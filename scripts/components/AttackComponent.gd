extends Node3D
class_name AttackComponent

signal attack_done

var attack_presets: Array[AttackPreset]
var can_attack: bool = true
var current_attack: AttackPreset = null

func _ready() -> void:
	add_attack_preset(
		AttackPreset.instantiate_preset(
			get_parent(),
			"Forward",
			Enums.AttackStyles.FORWARD,
			100,
			4))
	add_attack_preset(
		AttackPreset.instantiate_preset(
			get_parent(),
			"Fireball",
			Enums.AttackStyles.FIREBALL,
			200,
			6))
	add_attack_preset(
		AttackPreset.instantiate_preset(
			get_parent(),
			"Heal",
			Enums.AttackStyles.HEAL,
			200,
			5))

func add_attack_preset(preset: AttackPreset):
	attack_presets.append(preset)
	add_child(preset)

func do_attack(targets: Array[Node3D], preset: AttackPreset):
	var preset_id = attack_presets.find(preset)
	if (preset_id == -1):
		push_error("The attack preset cannot be found")
	if (!can_attack):
		return
	can_attack = false
	if (current_attack != null):
		current_attack.cooldown_timer.timeout.disconnect(on_cooldown_elaspsed)
	current_attack = preset
	current_attack.cooldown_timer.timeout.connect(on_cooldown_elaspsed)
	await attack_presets[preset_id].trigger_attack(targets)
	attack_done.emit()

func on_cooldown_elaspsed():
	can_attack = true
