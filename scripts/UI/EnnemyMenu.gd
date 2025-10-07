extends PanelContainer
class_name EnnemyMenu

@export var character: Node3D
var not_selected_style: StyleBox = preload("res://assets/UI/not_selected_ennemy_style.tres")
var selected_style: StyleBox = preload("res://assets/UI/selected_ennemy_style.tres")

func _ready() -> void:
	$MarginContainer/HBoxContainer/EnnemyNameLabel.text = character.name
	$MarginContainer/HBoxContainer/CharacterHealthBar.set_character(character)
	set_selected(false)

func set_selected(selected: bool):
	if selected:
		add_theme_stylebox_override("panel", selected_style)
	else:
		add_theme_stylebox_override("panel", not_selected_style)
