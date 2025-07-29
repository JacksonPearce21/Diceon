extends Button

var card_price = 10
@onready var description_box = $Discription_Box
@onready var buy_btn = $Discription_Box/Buy_btn
var card_scene = "res://Scenes/card_sharp.tscn"


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
		get_parent().remove_child(self)
		CardManager.card_bought(self)
	else:
		pass

func disable_shop_features():
	$Discription_Box/Buy_btn.visible = false
