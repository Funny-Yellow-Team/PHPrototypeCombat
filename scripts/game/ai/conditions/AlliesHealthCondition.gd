extends BaseCondition
class_name AlliesHealthCondition

@export var number_of_allies: int
@export var percentage_of_health: int
@export var comparator: Enums.Comparator

func validate_condition() -> bool:
	var allies = GameInfo.ennemies.duplicate()
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
