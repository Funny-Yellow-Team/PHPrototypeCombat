extends BaseTarget
class_name RandomEnnemyTarget

@export var include_self: bool

func retrieve_targets() -> Array[Node3D]:
	var ennemies = GameInfo.allies.duplicate()
	return [ennemies.pick_random()]
