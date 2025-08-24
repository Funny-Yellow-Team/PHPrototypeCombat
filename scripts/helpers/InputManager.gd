extends Node

signal input_mode_changed

var is_controller_mode: Enums.InputType = Enums.InputType.KEYBOARD
var character_inputs: Array[String] = ["character1_selection", "character2_selection", "character3_selection", "character4_selection"]
var attack_inputs: Array[String] = ["attack1_selection","attack2_selection","attack3_selection"]


var xbox_tex: Dictionary[String, Texture2D] = {
	"character1_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_LT.png"),
	"character2_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_LB.png"),
	"character3_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_RB.png"),
	"character4_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_RT.png"),
	"attack1_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_X.png"),
	"attack2_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_A.png"),
	"attack3_selection": preload("res://assets/textures/inputs/Xbox Series/XboxSeriesX_B.png")
}
var ps_tex: Dictionary[String, Texture2D] = {
	"character1_selection": preload("res://assets/textures/inputs/PS5/PS5_L1.png"),
	"character2_selection": preload("res://assets/textures/inputs/PS5/PS5_L2.png"),
	"character3_selection": preload("res://assets/textures/inputs/PS5/PS5_R2.png"),
	"character4_selection": preload("res://assets/textures/inputs/PS5/PS5_R1.png"),
	"attack1_selection": preload("res://assets/textures/inputs/PS5/PS5_Square.png"),
	"attack2_selection": preload("res://assets/textures/inputs/PS5/PS5_Cross.png"),
	"attack3_selection": preload("res://assets/textures/inputs/PS5/PS5_Circle.png")
}
var kb_tex: Dictionary[String, Texture2D] = {
	"character1_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/Arrow_Left_Key_Light.png"),
	"character2_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/Arrow_Up_Key_Light.png"),
	"character3_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/Arrow_Down_Key_Light.png"),
	"character4_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/Arrow_Right_Key_Light.png"),
	"attack1_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/A_Key_Light.png"),
	"attack2_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/E_Key_Light.png"),
	"attack3_selection": preload("res://assets/textures/inputs/Keyboard & Mouse/Light/R_Key_Light.png")
}
var texture: Dictionary[String, Texture2D] = kb_tex


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event is InputEventKey:
			change_input_mode(Enums.InputType.KEYBOARD)
		elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
			# Find which controller is used
			var joypad_id := event.device
			var joy_name := Input.get_joy_name(joypad_id).to_lower()
			if "xbox" in joy_name or "xinput" in joy_name:
				change_input_mode(Enums.InputType.XBOX)
			elif "playstation" in joy_name or "ps4" in joy_name or "ps5" in joy_name or "sony" in joy_name:
				change_input_mode(Enums.InputType.PLAYSTATION)
			else:
				change_input_mode(Enums.InputType.KEYBOARD)

func change_input_mode(controller_mode: Enums.InputType):
	is_controller_mode = controller_mode
	match (is_controller_mode):
		Enums.InputType.KEYBOARD:
			texture = kb_tex
		Enums.InputType.XBOX:
			texture = xbox_tex
		Enums.InputType.PLAYSTATION:
			texture = ps_tex
	emit_signal("input_mode_changed")
