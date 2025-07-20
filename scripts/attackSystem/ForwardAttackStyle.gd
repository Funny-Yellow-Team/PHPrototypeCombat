extends BaseAttackStyle
class_name ForwardAttackStyle

func trigger_attack(source: Node3D, targets: Array[Node3D], damage: int):
	var src_mov_cmp = ServiceContainer.get_movement_component(source)
	var src_anim_cmp = ServiceContainer.get_animation_component(source)
	var target = targets[0]
	var trg_heal_cmp = ServiceContainer.get_health_component(target)
	var original_pos = source.position
	var original_orientation = source.rotation.y
	src_mov_cmp.distance_margin = 3
	src_mov_cmp.set_target_position(target.global_position)
	await src_mov_cmp.reached_target
	src_anim_cmp.play("CharacterAnimLib/ForwardAttackAnim")
	trg_heal_cmp.hurt(damage)
	while true:
		var args = await src_anim_cmp.animation_finished
		if args == "CharacterAnimLib/ForwardAttackAnim":
			break
	src_mov_cmp.distance_margin = 0.01
	src_mov_cmp.set_target_position(original_pos)
	await src_mov_cmp.reached_target
	src_mov_cmp.set_orientation(original_orientation)
	emit_signal("attack_done")
