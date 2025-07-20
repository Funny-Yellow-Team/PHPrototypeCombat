extends Node
class_name BaseAttackStyle

signal attack_done

func _init() -> void:
	if (self.get_script() == preload("res://scripts/attackSystem/BaseAttackStyle.gd")):
		push_error("Cannot instantiate base attack type directly!")

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	pass

# The idea is to inherit this class, override trigger_attack
# and call the appropriate components to orchestrate the attack.
# For example, call the movement component to move the character (source)
# towards the other character (target), once movement is complete use the
# animation component to use the attack anim, once that is done use
# the heal component to damage the target... etc...
# When the game designer will want to create an attack, he will be able to
# select through all the attack style to choose what the attack will look like,
# while still be able to configure the damage it does.
