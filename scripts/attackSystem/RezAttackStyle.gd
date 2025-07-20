extends BaseAttackStyle
class_name RezAttackStyle

var rez_ball_asset: PackedScene = preload("res://assets/prefabs/RezBall.tscn")

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	var rez_ball_instance: Node3D = rez_ball_asset.instantiate()
	source.get_tree().current_scene.add_child(rez_ball_instance)
	rez_ball_instance.global_position = source.global_position
	var rez_ball_mov_cmp = ServiceContainer.get_movement_component(rez_ball_instance)
	var target = targets[0]
	var trg_heal_cmp = ServiceContainer.get_health_component(target)
	rez_ball_mov_cmp.set_target_position(target.global_position + Vector3(0, 3, 0))
	await rez_ball_mov_cmp.reached_target
	rez_ball_mov_cmp.set_target_position(target.global_position)
	await rez_ball_mov_cmp.reached_target
	trg_heal_cmp.revive(damage)
	rez_ball_instance.queue_free()
	emit_signal("attack_done")
