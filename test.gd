extends Button

@export var perso1: Node3D
@export var perso2: Node3D
@export var target: Node3D
@export var target2: Node3D
@export var attack_type: Enums.AttackStyles

func _on_pressed() -> void:
	var atk_cmp = ServiceContainer.get_attack_component(perso1)
	var atk_cmp2 = ServiceContainer.get_attack_component(perso2)
	#atk_cmp.do_attack([target], Enums.AttackStyles.FIREBALL)
	atk_cmp2.do_attack([perso1], attack_type, 250)
