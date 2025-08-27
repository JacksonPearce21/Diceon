extends Node2D


func _ready():
	CardManager.shop_slots = [
		$shopping/Bar/card1,
		$shopping/Bar/card2,
		$shopping/Bar/card3
	]
	CardManager.populate_shop()
	pass

func _on_next_round_pressed() -> void:
	GlobalManager.out_of_shop = true
	GlobalManager.next_round()
	GlobalManager.slide_out(self)
	await get_tree().create_timer(GlobalManager.tween_out_dur).timeout
	self.hide()


func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	
