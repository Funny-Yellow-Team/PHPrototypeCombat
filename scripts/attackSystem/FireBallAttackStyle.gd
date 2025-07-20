extends BaseAttackStyle
class_name FireBallAttackStyle

var fire_ball_asset: PackedScene = preload("res://assets/prefabs/FireBall.tscn")

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	var fire_ball_instance: Node3D = fire_ball_asset.instantiate()
	source.get_tree().current_scene.add_child(fire_ball_instance)
	fire_ball_instance.global_position = source.global_position
	var fire_ball_mov_cmp = ServiceContainer.get_movement_component(fire_ball_instance)
	var target = targets[0]
	var trg_heal_cmp = ServiceContainer.get_health_component(target)
	fire_ball_mov_cmp.set_target_position(target.global_position)
	await fire_ball_mov_cmp.reached_target
	trg_heal_cmp.hurt(damage)
	fire_ball_instance.queue_free()
	emit_signal("attack_done")
