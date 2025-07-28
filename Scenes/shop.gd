extends Panel


func _ready():
	GlobalManager.shopping = true
	CardManager.shop_slots = [
		$shopping/Bar/card1/Card,
		$shopping/Bar/card2/Card,
		$shopping/Bar/card3/Card
	]
	CardManager.populate_shop()
	pass

func _on_next_round_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
	GlobalManager.shopping = false
	GlobalManager.next_round()


func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	
