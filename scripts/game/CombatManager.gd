extends Node3D
class_name CombatManager

var display_list = preload("res://scripts/helpers/DisplayList.gd").new()
@export var ally_templates: Array[CharacterTemplate]
var allies: Array[Node3D]
@export var ennemy_templates: Array[EnnemyTemplate]
var ennemies: Array[Node3D]
@export var character_menu_container: Control
@export var ennemy_menu_container: Control
var character_menu_prefab: PackedScene = preload("res://assets/prefabs/CharacterMenu.tscn")
var ennemy_menu_prefab: PackedScene = preload("res://assets/prefabs/EnnemyMenu.tscn")
var ally_spawn_points: Array[Node3D]
var ennemy_spawn_points: Array[Node3D]
var ennemy_menu_list: Array[EnnemyMenu]
var selected_ennemy_idx: int
var last_selected_ennemy: EnnemyMenu

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
		var character = instantiate_ennemy(
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
	for i in range(0, ennemies.size()):
		instantiate_ennemy_menu(ennemies[i])
	for i in range(0, allies.size()):
		instantiate_character_menu(allies[i], i)
	set_selected_ennemy.call_deferred(0)
	GameInfo.fill_data(allies, ennemies)

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_up")):
		selected_ennemy_idx = move_idx(-2)
		set_selected_ennemy(selected_ennemy_idx)
	if (Input.is_action_just_pressed("ui_down")):
		selected_ennemy_idx = move_idx(2)
		set_selected_ennemy(selected_ennemy_idx)
	if (Input.is_action_just_pressed("ui_left")):
		selected_ennemy_idx = move_idx(-(selected_ennemy_idx % 2))
		set_selected_ennemy(selected_ennemy_idx)
	if (Input.is_action_just_pressed("ui_right")):
		selected_ennemy_idx = move_idx(abs(1 - (selected_ennemy_idx % 2)))
		set_selected_ennemy(selected_ennemy_idx)

func move_idx(offset: int):
	var new_idx = selected_ennemy_idx + offset
	if (new_idx >= ennemy_menu_container.get_children().size()):
		new_idx = selected_ennemy_idx
	if (new_idx < 0):
		new_idx = selected_ennemy_idx
	return new_idx

func set_selected_ennemy(idx: int):
	var ennemy_menu = ennemy_menu_container.get_children()[idx] as EnnemyMenu
	if (last_selected_ennemy != null):
		last_selected_ennemy.set_selected(false)
		var old_select_cmp = ServiceContainer.get_selection_component(last_selected_ennemy.character)
		old_select_cmp.set_selected(false)
	ennemy_menu.set_selected(true)
	var select_cmp = ServiceContainer.get_selection_component(ennemy_menu.character)
	select_cmp.set_selected(true)
	last_selected_ennemy = ennemy_menu

func instantiate_character(template: CharacterTemplate, spawn_position: Vector3, spawn_rotation: Vector3):
	var character: Node3D = template.prefab.instantiate()
	get_tree().current_scene.add_child.call_deferred(character)
	character.name = template.character_name
	character.global_position = spawn_position
	character.rotation = spawn_rotation
	var heal_cmp = ServiceContainer.get_health_component(character)
	heal_cmp.base_health = template.max_health
	heal_cmp.current_health = template.max_health
	var display_cmp = ServiceContainer.get_display_component(character)
	var model = display_list.display_prefabs[template.model].instantiate()
	display_cmp.add_child(model)
	var atk_cmp = ServiceContainer.get_attack_component(character)
	for preset in template.attack_presets:
		instantiate_attack_preset(preset, character, atk_cmp)
	return character

func instantiate_ennemy(template: EnnemyTemplate, spawn_position: Vector3, spawn_rotation: Vector3):
	var character = instantiate_character(
		template,
		spawn_position,
		spawn_rotation
	)
	for gambit in template.AI_gambits:
		gambit.initialize_condition(character)
	var ai_cmp = ServiceContainer.get_ai_component(character)
	ai_cmp.initialize.call_deferred(template.AI_gambits)
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

func instantiate_character_menu(character: Node3D, idx: int):
	var menu = character_menu_prefab.instantiate() as CharacterMenu
	menu.character = character
	menu.allies = allies
	menu.ennemies = ennemies
	menu.get_selected_ennemy = get_selected_ennemy
	menu.set_input_name(InputManager.character_inputs[idx])
	character_menu_container.add_child.call_deferred(menu)

func instantiate_ennemy_menu(character: Node3D):
	var menu = ennemy_menu_prefab.instantiate() as EnnemyMenu
	menu.character = character
	ennemy_menu_container.add_child.call_deferred(menu)

func get_selected_ennemy() -> Node3D:
	return last_selected_ennemy.character
