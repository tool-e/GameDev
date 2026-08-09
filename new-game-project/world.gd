extends Node


@onready var win_screen: ColorRect = $Win/ColorRect

func game_over() -> void:
	win_screen.show()
