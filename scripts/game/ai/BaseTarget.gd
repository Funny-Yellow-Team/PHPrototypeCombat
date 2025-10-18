extends Resource
class_name BaseTarget

var character: Node3D

func _init() -> void:
	if (self.get_script() == preload("res://scripts/game/ai/BaseTarget.gd")):
		push_error("Cannot instantiate base target directly!")

func initialize_target(character_self: Node3D):
	character = character_self

func retrieve_targets() -> Array[Node3D]:
	return []
