extends Button

var card_price = 10
@onready var description_box = $Discription_Box
@onready var buy_btn = $Discription_Box/Buy_btn
@onready var effect_panel = $Panel
@onready var effect_label = $Panel/Effect
var card_scene = "res://Scenes/high_roller_card.tscn"

func _ready():
	add_to_group("Card")
	hide_description()
	buy_btn.text = "-$" + str(card_price)
	effect_panel.hide()

func _process(delta):
	if CardEffects.show_dealers_cut_effect:
		effect_label.text = CardEffects.dealers_cut_label
		effect_panel.show()
	else:
		effect_panel.hide()

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
