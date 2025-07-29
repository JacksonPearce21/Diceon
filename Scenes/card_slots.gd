extends Node2D

func _ready():
	CardManager.card_slots = [
		$Bar/card_slot,
		$Bar/card_slot2,
		$Bar/card_slot3,
		$Bar/card_slot4,
		$Bar/card_slot5
		]
	CardManager.load_cards_into_slots()

func load_cards_into_slots():
	for i in CardManager.current_cards.size():
		if i >= CardManager.card_slots.size():
			break
		var card_data = CardManager.current_cards[i]
		var card_instance = null
		card_instance = card_data.instantiate()
		CardManager.card_slots[i].add_child(card_instance)

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	
