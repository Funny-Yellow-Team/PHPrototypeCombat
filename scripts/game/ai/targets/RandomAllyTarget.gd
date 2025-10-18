extends BaseTarget
class_name RandomAllyTarget

@export var include_self: bool

func retrieve_targets() -> Array[Node3D]:
	var allies = GameInfo.ennemies.duplicate()
	if !include_self:
		allies.erase(character)
	return [allies.pick_random()]
