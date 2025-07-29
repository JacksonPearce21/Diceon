extends Node

@onready var shop_slots = []
var card_slots: Array = []
var card_path
var instanceable_card
var current_card
var card_instance

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

func load_cards_into_slots():
	if card_slots.is_empty() or current_cards.is_empty():
		return
	for i in current_cards.size():
		if i >= card_slots.size():
			break
		var card_data = current_cards[i]
		card_instance = card_data.instantiate()
		card_slots[i].add_child(card_instance)
		card_instance.disable_shop_features()

func card_bought(card):
	instanceable_card = load(card.scene_file_path)
	current_cards.append(instanceable_card)
	load_cards_into_slots()

func select_card(card):
	current_card = card
	card.show_description()
