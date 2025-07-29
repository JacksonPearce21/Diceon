extends Node2D

func _ready():
	CardManager.card_slots = [
		$Bar/card_slot,
		$Bar/card_slot2,
		$Bar/card_slot3,
		$Bar/card_slot4,
		$Bar/card_slot5
		]

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	
