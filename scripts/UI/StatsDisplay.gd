extends Node3D
class_name StatsDisplay

@export var stats_label: Label
@export var time_to_sum: float
@export var time_to_fade: int
var hurt_color: Color = Color("#F36565FF")
var heal_color: Color = Color("#65F365FF")
var atk_color: Color = Color("#FFFFFFFF")
var is_triggered: bool = false
var is_fading: bool = false
var sum: float = 0
var total_amount: int = 0

func _ready() -> void:
	$StatsSprite.offset = Vector2(randf_range(-25, 25), randf_range(-25, 25))

func _process(delta: float) -> void:
	if (is_triggered):
		sum += delta
		stats_label.text = str(int(sum / time_to_sum * total_amount))
		if (sum > time_to_sum):
			stats_label.text = str(total_amount)
			is_triggered = false
			$StayTimer.start()
	elif (is_fading):
		sum += delta
		var alpha = 1 - (sum / time_to_fade)
		stats_label.modulate = Color(1, 1, 1, alpha)
		if (alpha <= 0):
			queue_free()

func trigger_stat_display(amount: int, type: Enums.StatTypes):
	if (is_triggered):
		return
	if (stats_label == null):
		return
	is_triggered = true
	total_amount = amount
	stats_label.text = str(sum)
	match type:
		Enums.StatTypes.HURT:
			stats_label.add_theme_color_override("font_color", hurt_color)
		Enums.StatTypes.HEAL:
			stats_label.add_theme_color_override("font_color", heal_color)
		Enums.StatTypes.ATK:
			stats_label.add_theme_color_override("font_color", atk_color)

func _on_stay_timer_timeout() -> void:
	is_fading = true
	sum = 0
