extends Panel


func _ready():
	CardManager.shop_slots = [
		$shopping/Bar/card1,
		$shopping/Bar/card2,
		$shopping/Bar/card3
	]
	CardManager.populate_shop()
	pass

func _on_next_round_pressed() -> void:
	self.hide()
	GlobalManager.out_of_shop = true
	GlobalManager.next_round()


func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	
