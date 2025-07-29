extends Node

@onready var shop_slots = []
@onready var card_slots = []

var all_cards = [
	preload("res://Scenes/high_roller_card.tscn"),
	preload("res://Scenes/dealers_cut.tscn"),
	preload("res://Scenes/on_the_edge.tscn"),
	preload("res://Scenes/card_sharp.tscn")
]

func populate_shop():
	var available = []
	for card_scene in all_cards:
		if not current_cards.has(card_scene):
			available.append(card_scene)
	available.shuffle()
	for i in shop_slots.size():
		if i < available.size():
			var card = available[i].instantiate()
			clear_children(shop_slots[i])
			shop_slots[i].add_child(card)

func clear_children(node):
	for child in node.get_children():
		child.queue_free()

var current_cards: Array = []

func card_bought(card):
	current_cards.append(card.scene_file_path)

var current_card

func select_card(card):
	current_card = card
	card.show_description()
	
func add_to_slot():
	pass
	
func add_card():
	pass
