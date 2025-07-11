extends Node3D

@export var target: Node3D
@export var enable_hurt: bool = false

func on_target_reached():
	print_debug("target reached")
	debug_move()

func _on_timer_timeout() -> void:
	if !enable_hurt:
		return
	debug_heal()

func debug_move():
	var mov_cmp = ServiceContainer.get_movement_component(self)
	var target = Vector3(randf_range(-6, 6), mov_cmp.global_position.y, randf_range(-14, 14))
	print_debug(target)
	mov_cmp.set_speed(randi_range(100, 300))
	mov_cmp.set_target_position(target)

func debug_heal():
	var heal_cmp = ServiceContainer.get_health_component(self)
	heal_cmp.hurt(randi_range(10, 250))
	return
	var rng = randi_range(0, 1)
	match rng:
		0:
			heal_cmp.hurt(randi_range(10, 250))
		1:
			heal_cmp.heal(randi_range(10, 250))

func _on_button_pressed() -> void:
	return
	var atk_cmp = ServiceContainer.get_attack_component(self)
	atk_cmp.do_forward_attack(target)
