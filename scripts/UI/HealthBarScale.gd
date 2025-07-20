extends MeshInstance3D

@onready var camera = get_viewport().get_camera_3d()
@export var base_scale = Vector3.ONE
@export var screen_size = 100.0 # Desired size in pixels (tweak as needed)

func _process(_delta):
	if camera:
		var distance = (global_transform.origin - camera.global_transform.origin).length()
		var fov = camera.fov
		var viewport_height = get_viewport().size.y
		var scale_factor = 2.0 * distance * tan(deg_to_rad(fov/2.0)) / viewport_height * screen_size
		scale = base_scale * scale_factor
