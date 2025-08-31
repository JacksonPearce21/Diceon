extends Panel

@onready var money_label = $SideBar/Panel3/Panel/Money

func _process(delta):
	money_label.text = "$" + str(GlobalManager.money)
	

func _on_click_catcher_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		get_tree().call_group("cards", "hide_description")	

func _on_close_game_pressed() -> void:
	get_tree().quit()
