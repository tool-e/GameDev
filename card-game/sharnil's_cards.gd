extends Node2D

@onready var card_manager: Node2D = $".."

func _ready() -> void:
	self.scale = Vector2( card_manager.cardWIDTH, card_manager.cardLENGTH)
