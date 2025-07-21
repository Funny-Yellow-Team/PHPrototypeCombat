extends VBoxContainer
class_name CharacterMenu

@export var character: Node3D
var allies: Array[Node3D]
var ennemies: Array[Node3D]
@export var is_focused_debug: bool = false
var atk_cmp: AttackComponent
var atk_buttons: Array[Button]
var selected_attack: AttackPreset
var trg_buttons: Array[Button]
var selected_targets: Array[Node3D]

func _ready() -> void:
	$CharacterLabel.text = character.name
	$CharacterHealthBar.set_character(character)
	atk_cmp = ServiceContainer.get_attack_component(character)
	atk_cmp.attack_done.connect(on_attack_done)
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			var btn = AttackButton.instantiate_button(character, atk_cmp.attack_presets[i])
			btn.attack_button_pressed.connect(on_attack_button_pressed)
			$AttackContainer.add_child(btn)
			atk_buttons.append(btn)
	if is_focused_debug:
		atk_buttons[0].grab_focus()

func _process(delta: float) -> void:
	set_attack_button_disabled(!atk_cmp.can_attack)
	if (atk_cmp.current_attack != null):
		$CooldownBar.value = atk_cmp.current_attack.cooldown_timer.time_left

func set_attack_button_disabled(disabled: bool):
	for i in range(0, 3):
		if (i < atk_cmp.attack_presets.size()):
			atk_buttons[i].disabled = disabled

func on_attack_button_pressed(preset: AttackPreset):
	selected_attack = preset
	if (selected_attack.is_multi_target):
		if (selected_attack.target_type == Enums.TargetTypes.ALLY):
			selected_targets = allies
		else:
			selected_targets = ennemies
		launch_attack()
	else:
		if (selected_attack.target_type == Enums.TargetTypes.ALLY):
			for ally in allies:
				bind_target_button(ally)
		else:
			for ennemy in ennemies:
				bind_target_button(ennemy)
		$AttackContainer.visible = false
		$TargetContainer.visible = true

func on_target_button_pressed(target: Node3D):
	selected_targets = [target]
	launch_attack()

func launch_attack():
	atk_cmp.do_attack(selected_targets, selected_attack)
	reset_targets()

func on_attack_done():
	$CooldownBar.max_value = atk_cmp.current_attack.cooldown
	$CooldownBar.value = atk_cmp.current_attack.cooldown

func bind_target_button(selected_character: Node3D):
	var btn = TargetButton.instantiate_button(selected_character)
	btn.target_button_pressed.connect(on_target_button_pressed)
	$TargetContainer.add_child(btn)
	trg_buttons.append(btn)

func _on_back_button_pressed() -> void:
	reset_targets()

func reset_targets():
	selected_attack = null
	selected_targets = []
	$AttackContainer.visible = true
	$TargetContainer.visible = false
	for btn in trg_buttons:
		btn.queue_free()
	trg_buttons = []
