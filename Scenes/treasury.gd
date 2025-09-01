extends Button

var card_price = 12
@onready var description_box = $Discription_Box
@onready var buy_btn = $Discription_Box/Buy_btn
@onready var effect_panel = $Panel
@onready var effect_label = $Panel/Effect
@onready var current_label = $Discription_Box/currently
@onready var sell = $Discription_Box/sell_btn
var card_scene = "res://Scenes/on_a_roll.tscn"
var shown

func _ready():
	add_to_group("Card")
	hide_description()
	buy_btn.text = "-$" + str(card_price)
	effect_panel.hide()

func _process(delta):
	current_label.text = "Currently: +" + str(GlobalManager.money)
	if CardEffects.show_treasury:
		effect_label.text = CardEffects.treasury_label
		effect_panel.show()
	else:
		effect_panel.hide()

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


func _on_sell_btn_pressed() -> void:
	CardManager.sell(self)
	$Discription_Box/Buy_btn.visible = true
	$Discription_Box/sell_btn.hide()
