extends Node

var SAVEFILE = "res://save.bin"

func SaveGame() -> void:
	var file = FileAccess.open(SAVEFILE,  FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"GOLD": Game.GOLD
	}

	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func LoadGame() -> void:
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE) == true:
		var currentline = JSON.parse_string(file.get_line())
		if currentline:
			Game.GOLD = currentline["GOLD"]
			Game.playerHP = currentline["playerHP"]
