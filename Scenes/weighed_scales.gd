extends Button

var card_price = 7
@onready var description_box = $Discription_Box
@onready var buy_btn = $Discription_Box/Buy_btn
@onready var sell = $Discription_Box/sell_btn
var card_scene = "res://Scenes/high_roller_card.tscn"
var shown

func _ready():
	add_to_group("Card")
	hide_description()
	buy_btn.text = "-$" + str(card_price)

func _process(delta):
	pass

func show_description():
	description_box.show()
	shown = true

func hide_description():
	description_box.hide()
	shown = false

func _on_pressed():
	if shown:
		get_tree().call_group("cards", "hide_description")
	else:
		get_tree().call_group("cards", "hide_description")
		CardManager.select_card(self)

func _on_buy_btn_pressed():
	if CardManager.current_cards.size() < 5:
		if GlobalManager.money >= card_price:
			GlobalManager.money -= card_price
			get_parent().remove_child(self)
			CardManager.card_bought(self)
	else:
		pass

func disable_shop_features():
	$Discription_Box/Buy_btn.visible = false
	$Discription_Box/sell_btn.show()


func _on_sell_btn_pressed():
	CardManager.sell(self)
	$Discription_Box/Buy_btn.visible = true
	$Discription_Box/sell_btn.hide()
