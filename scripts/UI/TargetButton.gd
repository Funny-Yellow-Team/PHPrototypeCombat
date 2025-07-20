extends Button
class_name TargetButton

signal target_button_pressed(target: Node3D)

var target: Node3D

static func instantiate_button(target: Node3D):
	var button = TargetButton.new()
	button.target = target
	button.text = target.name
	button.pressed.connect(button.on_button_pressed)
	return button

func on_button_pressed():
	target_button_pressed.emit(target)
