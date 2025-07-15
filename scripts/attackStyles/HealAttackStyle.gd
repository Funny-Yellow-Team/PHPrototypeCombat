extends BaseAttackStyle
class_name HealAttackStyle

var heal_ball_asset: PackedScene = preload("res://assets/prefabs/HealBall.tscn")

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	var heal_ball_instance: Node3D = heal_ball_asset.instantiate()
	source.get_tree().current_scene.add_child(heal_ball_instance)
	heal_ball_instance.global_position = source.global_position
	var heal_ball_mov_cmp = ServiceContainer.get_movement_component(heal_ball_instance)
	var target = targets[0]
	var trg_heal_cmp = ServiceContainer.get_health_component(target)
	heal_ball_mov_cmp.set_target_position(target.global_position + Vector3(0, 3, 0))
	await heal_ball_mov_cmp.reached_target
	heal_ball_mov_cmp.set_target_position(target.global_position)
	await heal_ball_mov_cmp.reached_target
	trg_heal_cmp.heal(damage)
	heal_ball_instance.queue_free()
	emit_signal("attack_done")
