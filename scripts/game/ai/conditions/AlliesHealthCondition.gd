extends BaseCondition
class_name AlliesHealthCondition

@export_group("Condition")
@export var number_of_allies: int
@export var comparator: Enums.Comparator
@export_range(0, 100, 1.0, "suffix:%") var percentage_of_health: int

func validate_condition() -> bool:
	var allies = GameInfo.npcs.duplicate()
	allies.erase(character)
	var result = 0
	for ally in allies:
		var heal_cmp = ServiceContainer.get_health_component(ally)
		if (compare_health(heal_cmp.current_health, heal_cmp.base_health)):
			result += 1
	return result >= number_of_allies

func compare_health(health: int, health_total: int) -> bool:
	var amount_to_compare = health_total / 100 * percentage_of_health
	if comparator == Enums.Comparator.MORE_THAN:
		return health > amount_to_compare
	else:
		return health < amount_to_compare
