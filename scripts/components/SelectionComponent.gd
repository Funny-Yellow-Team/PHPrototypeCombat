extends Node3D
class_name SelectionComponent

@export var selection_display: Node3D
var is_selected: bool

func _ready() -> void:
	set_selected(false)

func set_selected(selected: bool):
	selection_display.visible = selected
	is_selected = selected
