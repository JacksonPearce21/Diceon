extends Button

var card_price = 10
@onready var description_box = $Discription_Box
@onready var buy_btn = $Discription_Box/Buy_btn

func _ready():
	add_to_group("Card")
	hide_description()
	buy_btn.text = "-$" + str(card_price)

func show_description():
	description_box.show()

func hide_description():
	description_box.hide()

func _on_pressed():
	get_tree().call_group("cards", "hide_description")
	CardManager.select_card(self)
