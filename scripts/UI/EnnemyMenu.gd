extends PanelContainer
class_name EnnemyMenu

@export var character: Node3D

func _ready() -> void:
	$MarginContainer/HBoxContainer/EnnemyNameLabel.text = character.name
	$MarginContainer/HBoxContainer/CharacterHealthBar.set_character(character)
