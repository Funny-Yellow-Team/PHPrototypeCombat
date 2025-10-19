extends Node

var players: Array[Node3D]
var npcs: Array[Node3D]

func fill_data(allies_list: Array[Node3D], ennemies_list: Array[Node3D]):
	players = allies_list
	npcs = ennemies_list
