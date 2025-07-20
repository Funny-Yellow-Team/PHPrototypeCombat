extends Node
class_name CharacterTemplate

@export var character_name: String
@export var max_health: int
@export var attack_presets: Array[AttackPresetTemplate]
@export var prefab: PackedScene = preload("res://assets/prefabs/Character.tscn")
