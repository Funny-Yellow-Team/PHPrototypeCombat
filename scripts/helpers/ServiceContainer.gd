class_name ServiceContainer

static func get_animation_component(node: Node) -> AnimationComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var anim_cmp: AnimationComponent
	for child in node.get_children(true):
		if child is AnimationComponent:
			anim_cmp = child
	if anim_cmp == null:
		push_error("The node %s does not contain an AnimationComponent" % [node.name])
	return anim_cmp

static func get_attack_component(node: Node) -> AttackComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var attack_cmp: AttackComponent
	for child in node.get_children(true):
		if child is AttackComponent:
			attack_cmp = child
	if attack_cmp == null:
		push_error("The node %s does not contain an AttackComponent" % [node.name])
	return attack_cmp

static func get_display_component(node: Node) -> DisplayComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var display_cmp: DisplayComponent
	for child in node.get_children(true):
		if child is DisplayComponent:
			display_cmp = child
	if display_cmp == null:
		push_error("The node %s does not contain a DisplayComponent" % [node.name])
	return display_cmp

static func get_health_bar_component(node: Node) -> HealthBarComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var health_bar_cmp: HealthBarComponent
	for child in node.get_children(true):
		if child is HealthBarComponent:
			health_bar_cmp = child
	if health_bar_cmp == null:
		push_error("The node %s does not contain a HealthBarComponent" % [node.name])
	return health_bar_cmp

static func get_health_component(node: Node) -> HealthComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var health_cmp: HealthComponent
	for child in node.get_children(true):
		if child is HealthComponent:
			health_cmp = child
	if health_cmp == null:
		push_error("The node %s does not contain a HealthComponent" % [node.name])
	return health_cmp

static func get_movement_component(node: Node) -> MovementComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var movement_cmp: MovementComponent
	for child in node.get_children(true):
		if child is MovementComponent:
			movement_cmp = child
	if movement_cmp == null:
		push_error("The node %s does not contain a MovementComponent" % [node.name])
	return movement_cmp

static func get_selection_component(node: Node) -> SelectionComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var select_cmp: SelectionComponent
	for child in node.get_children(true):
		if child is SelectionComponent:
			select_cmp = child
	if select_cmp == null:
		push_error("The node %s does not contain a SelectionComponent" % [node.name])
	return select_cmp

static func get_ai_component(node: Node) -> AIComponent:
	if node == null:
		push_error("Node given in parameter is null")
	var ai_cmp: AIComponent
	for child in node.get_children(true):
		if child is AIComponent:
			ai_cmp = child
	if ai_cmp == null:
		push_error("The node %s does not contain a AIComponent" % [node.name])
	return ai_cmp
