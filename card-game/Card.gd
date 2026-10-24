extends Node2D

signal mouse_on
signal mouse_off

func _ready() -> void:
	# All cards must be a child of card manager or will error
	get_parent().connect_card_signals(self)

func _on_area_2d_mouse_entered() -> void:
	emit_signal("mouse_on", self)


func _on_area_2d_mouse_exited() -> void:
	emit_signal("mouse_off", self)
