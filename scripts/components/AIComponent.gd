extends Node3D
class_name AIComponent

var conditions: Array[BaseCondition]
var atk_cmp: AttackComponent
var heal_cmp: HealthComponent

func _ready() -> void:
	atk_cmp = ServiceContainer.get_attack_component(get_parent())
	heal_cmp = ServiceContainer.get_health_component(get_parent())

func initialize(conditions_list: Array[BaseCondition]):
	conditions = conditions_list
	for condition in conditions:
		atk_cmp.add_attack_preset(condition.attack_preset)

func _process(delta: float) -> void:
	if (!atk_cmp.can_attack):
		return
	for condition in conditions:
		if (condition.validate_condition()):
			atk_cmp.do_attack(condition.target.retrieve_targets(), condition.attack_preset)
