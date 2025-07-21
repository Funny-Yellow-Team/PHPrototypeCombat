extends RefCounted

var cheems_display = preload("res://assets/prefabs/display/CheemsDisplay.tscn")
var cirno_display = preload("res://assets/prefabs/display/CirnoDisplay.tscn")
var doge_cube_display = preload("res://assets/prefabs/display/DogeCubeDisplay.tscn")
var engineer_display = preload("res://assets/prefabs/display/EngineerDisplay.tscn")
var maxwell_display = preload("res://assets/prefabs/display/MaxwellDisplay.tscn")
var obama_display = preload("res://assets/prefabs/display/ObamaDisplay.tscn")
var oiiaiooo_display = preload("res://assets/prefabs/display/OiiaioooDisplay.tscn")
var sanae_display = preload("res://assets/prefabs/display/SanaeDisplay.tscn")

var display_prefabs : Dictionary = {
	Enums.CharacterModel.CHEEMS: cheems_display,
	Enums.CharacterModel.CIRNO: cirno_display,
	Enums.CharacterModel.DOGE_CUBE: doge_cube_display,
	Enums.CharacterModel.ENGINEER: engineer_display,
	Enums.CharacterModel.MAXWELL: maxwell_display,
	Enums.CharacterModel.OBAMA: obama_display,
	Enums.CharacterModel.OIIAIOOO: oiiaiooo_display,
	Enums.CharacterModel.SANAE: sanae_display
}
