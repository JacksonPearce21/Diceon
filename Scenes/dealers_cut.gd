extends Button

var card_price = 7
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

func _on_buy_btn_pressed():
	if GlobalManager.money >= card_price:
		GlobalManager.money -= card_price
		print("Card bought:", self.name)
	else:
		print("Not enough money!")

	for slot in CardManager.card_slots:
		if slot.get_child_count() == 0:
			get_parent().remove_child(self)
			slot.add_child(self)
			break
