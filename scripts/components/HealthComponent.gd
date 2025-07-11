extends Node3D
class_name HealthComponent

signal health_changed(new_health: int)
signal hurted(new_health: int, damage: int)
signal healed(new_health: int, heal_amount: int)
signal death()
signal revived()

var display_component: DisplayComponent
var animation_component: AnimationComponent
@export var base_health: int = 100
var current_health: int
var is_dead: bool = false

func _ready() -> void:
	current_health = base_health
	display_component = ServiceContainer.get_display_component(get_parent())
	animation_component = ServiceContainer.get_animation_component(get_parent())

func hurt(damage: int):
	if (is_dead):
		return
	current_health -= damage
	emit_signal("health_changed", current_health)
	emit_signal("hurted", current_health, damage)
	if (current_health <= 0):
		is_dead = true
		emit_signal("death")
		animation_component.play_death_animation()
		current_health = 0
	display_component.display_stat(damage, Enums.StatTypes.HURT)

func heal(heal_amount: int):
	if (is_dead):
		return
	current_health += heal_amount
	if (current_health > base_health):
		current_health = base_health
	emit_signal("health_changed", current_health)
	emit_signal("healed", current_health, heal_amount)
	display_component.display_stat(heal_amount, Enums.StatTypes.HEAL)

func revive(heal_amount: int):
	if (is_dead && heal_amount > 0):
		is_dead = false
		heal(heal_amount)
		animation_component.play_revive_animation()
		emit_signal("revived")
