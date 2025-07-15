extends CharacterBody3D
class_name MovementComponent

signal reached_target()

@export var movement_speed: = 5
@export var distance_margin: float = 0.1
var target_position: Vector3
var close_to_target: bool = true
var parent_node: Node3D
var original_relative_position: Vector3 = position

func _ready() -> void:
	target_position = global_position
	parent_node = get_parent_node_3d()

func _physics_process(delta: float) -> void:
	if (!close_to_target):
		velocity = (target_position - global_position).normalized() * movement_speed
		move_and_slide()
		parent_node.global_position = global_position
		position = original_relative_position
		if (global_position.distance_to(target_position) < distance_margin):
			close_to_target = true
			emit_signal("reached_target")

func set_target_position(new_position: Vector3):
	target_position = new_position
	parent_node.look_at(target_position, Vector3.UP)
	close_to_target = false

func set_orientation(angle: float):
	parent_node.rotation.y = angle

func set_speed(new_speed: int):
	movement_speed = new_speed
