extends Node3D
class_name CombatManager

@export var ally_templates: Array[CharacterTemplate]
var allies: Array[Node3D]
@export var ennemy_templates: Array[CharacterTemplate]
var ennemies: Array[Node3D]
@export var control_node: Control
var character_menu_prefab: PackedScene = preload("res://assets/prefabs/CharacterMenu.tscn")
var ally_spawn_points: Array[Node3D]
var ennemy_spawn_points: Array[Node3D]

func _ready() -> void:
	ally_spawn_points.append($AllySpawnPoint1)
	ally_spawn_points.append($AllySpawnPoint2)
	ally_spawn_points.append($AllySpawnPoint3)
	ally_spawn_points.append($AllySpawnPoint4)
	ennemy_spawn_points.append($EnnemySpawnPoint1)
	ennemy_spawn_points.append($EnnemySpawnPoint2)
	ennemy_spawn_points.append($EnnemySpawnPoint3)
	ennemy_spawn_points.append($EnnemySpawnPoint4)
	ennemy_spawn_points.append($EnnemySpawnPoint5)
	ennemy_spawn_points.append($EnnemySpawnPoint6)
	ennemy_spawn_points.append($EnnemySpawnPoint7)
	ennemy_spawn_points.append($EnnemySpawnPoint8)
	for j in range(0, ennemy_templates.size()):
		var character = instantiate_character(
			ennemy_templates[j],
			ennemy_spawn_points[j].global_position,
			ennemy_spawn_points[j].rotation)
		ennemies.append(character)
	for i in range(0, ally_templates.size()):
		var character = instantiate_character(
			ally_templates[i],
			ally_spawn_points[i].global_position,
			ally_spawn_points[i].rotation)
		allies.append(character)
	for ally in allies:
		instantiate_character_menu(ally)

func instantiate_character(template: CharacterTemplate, spawn_position: Vector3, spawn_rotation: Vector3):
	var character: Node3D = template.prefab.instantiate()
	get_tree().current_scene.add_child.call_deferred(character)
	character.name = template.character_name
	character.global_position = spawn_position
	character.rotation = spawn_rotation
	var heal_cmp = ServiceContainer.get_health_component(character)
	heal_cmp.base_health = template.max_health
	heal_cmp.current_health = template.max_health
	var atk_cmp = ServiceContainer.get_attack_component(character)
	for preset in template.attack_presets:
		instantiate_attack_preset(preset, character, atk_cmp)
	return character

func instantiate_attack_preset(template: AttackPresetTemplate, character: Node3D, atk_cmp: AttackComponent):
	atk_cmp.add_attack_preset(AttackPreset.instantiate_preset(
		character,
		template.attack_name,
		template.attack_style,
		template.damage,
		template.target_type,
		template.is_multi_target,
		template.cooldown
	))

func instantiate_character_menu(character: Node3D):
	var menu = character_menu_prefab.instantiate() as CharacterMenu
	menu.character = character
	menu.allies = allies
	menu.ennemies = ennemies
	control_node.add_child.call_deferred(menu)
