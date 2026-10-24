extends Node2D

const cardWIDTH = null;
const cardLENGTH = null;

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var card = raycast_check_for_card()
		else:
			print("Left click released")

func connect_card_signals(card):
	card.connect("mouse_on", mouse_on_card)
	card.connect("mouse_off", mouse_off_card)

func mouse_on_card(card):
	print("mouse on")

func mouse_off_card(card):
	print("mouse off")

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null
	
