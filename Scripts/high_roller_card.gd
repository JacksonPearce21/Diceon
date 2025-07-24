extends Button

@onready var description_box = $Discription_Box

func _ready():
	add_to_group("Card")
	hide_description()

func show_description():
	description_box.show()

func hide_description():
	description_box.hide()


func _on_pressed():
	get_tree().call_group("cards", "hide_description")
	CardManager.select_card(self)
