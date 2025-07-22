extends Node

var current_card = null

func select_card(card):
	if current_card and current_card != card:
		current_card.hide_description()
	current_card = card
	card.show_description()
