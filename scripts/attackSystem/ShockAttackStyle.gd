extends BaseAttackStyle
class_name ShockAttackStyle

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	var src_mov_cmp = ServiceContainer.get_movement_component(source)
	var src_anim_cmp = ServiceContainer.get_animation_component(source)
	var original_pos = source.position
	var original_orientation = source.rotation.y
	src_mov_cmp.distance_margin = 3
	src_mov_cmp.set_target_position(source.global_position + Vector3(0,0,-8))
	await src_mov_cmp.reached_target
	src_anim_cmp.play("CharacterAnimLib/ShockAttackAnim")
	while true:
		var args = await src_anim_cmp.animation_finished
		if args == "CharacterAnimLib/ShockAttackAnim":
			break
	for target in targets:
		var trg_heal_cmp = ServiceContainer.get_health_component(target)
		trg_heal_cmp.hurt(damage)
	src_mov_cmp.distance_margin = 0.01
	src_mov_cmp.set_target_position(original_pos)
	await src_mov_cmp.reached_target
	src_mov_cmp.set_orientation(original_orientation)
	emit_signal("attack_done")
