extends Node
class_name AttackPreset

var source_node: Node3D
var style: Enums.AttackStyles
var damage: int
var cooldown: float
var can_attack: bool = true
var cooldown_timer: Timer

static func instantiate_preset(
		source_node: Node3D,
		name: String, 
		style: Enums.AttackStyles, 
		damage: int, 
		cooldown: float) -> AttackPreset:
	var preset = AttackPreset.new()
	preset.source_node = source_node
	preset.name = name
	preset.style = style
	preset.damage = damage
	preset.cooldown = cooldown
	preset.cooldown_timer = Timer.new()
	preset.cooldown_timer.autostart = false
	preset.cooldown_timer.wait_time = cooldown
	preset.cooldown_timer.one_shot = true
	preset.cooldown_timer.timeout.connect(preset.on_cooldown_elapsed)
	preset.add_child(preset.cooldown_timer)
	return preset

static func instanciate_attack_style(attack_style: Enums.AttackStyles) -> BaseAttackStyle:
	match attack_style:
		Enums.AttackStyles.FORWARD:
			return ForwardAttackStyle.new()
		Enums.AttackStyles.FIREBALL:
			return FireBallAttackStyle.new()
		Enums.AttackStyles.SHOCK:
			return ShockAttackStyle.new()
		Enums.AttackStyles.HEAL:
			return HealAttackStyle.new()
		Enums.AttackStyles.MULTIPLE_HEAL:
			return MultipleHealAttackStyle.new()
		Enums.AttackStyles.REZ:
			return RezAttackStyle.new()
	return null

func trigger_attack(targets: Array[Node3D]):
	if (can_attack):
		can_attack = false
		var style_instance = instanciate_attack_style(style)
		await style_instance.trigger_attack(source_node, targets, damage)
		cooldown_timer.start()

func on_cooldown_elapsed():
	can_attack = true
