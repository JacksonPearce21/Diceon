extends Node

var card_slots = 5
var used_slots = 0

var current_card = null

func select_card(card):
	if current_card and current_card != card:
		current_card.hide_description()
	current_card.show_description()
	
func add_to_slot():
	if used_slots == 0:
		pass
