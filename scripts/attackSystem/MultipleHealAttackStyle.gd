extends BaseAttackStyle
class_name MultipleHealAttackStyle

signal all_heal_done

var heal_count = 0
var target_nb = 0

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	target_nb = targets.size()
	for target in targets:
		var heal_attack_style = HealAttackStyle.new()
		heal_attack_style.attack_done.connect(on_heal_attack_done)
		heal_attack_style.trigger_attack(source, [target], damage)
	await self.all_heal_done
	emit_signal("attack_done")

func on_heal_attack_done():
	heal_count += 1
	if heal_count == target_nb:
		emit_signal("all_heal_done")
