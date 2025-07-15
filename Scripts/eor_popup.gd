extends Node2D
var money_made = 0

@onready var win_money = $"Pop-up/Win_money"
@onready var rolls_remaining = $"Pop-up/Rolls_left"
@onready var interest_label = $"Pop-up/Interest"
@onready var cash_out_btn = $"Pop-up/cash_out"

func _ready():
	cash_out_btn.disabled = true
	pass
	
func _process(delta):
	if GlobalManager.round_status == true:
		show()
		update_labels()
		GlobalManager.round_status = false
	
func calculate_money():
	cash_out_btn.text =  "Cash Out $" + str(money_made)
	
func update_money():
	GlobalManager.money += money_made
	
func update_labels():
	await get_tree().create_timer(1).timeout
	rolls_remaining.text =  "$" + str(GlobalManager.dice_rolls)
	money_made += GlobalManager.dice_rolls
	calculate_money()
	await get_tree().create_timer(1).timeout
	
	win_money.text =  "$" + str(GlobalManager.win_money)
	money_made += GlobalManager.win_money
	calculate_money()
	await get_tree().create_timer(1).timeout
	
	GlobalManager.calc_interest()
	interest_label.text =  "$" + str(GlobalManager.interest)
	money_made += GlobalManager.interest
	calculate_money()
	await get_tree().create_timer(1).timeout
	cash_out_btn.disabled = false
	
func reset_labels():
	cash_out_btn.text =  "Cash Out $0"
	interest_label.text =  "$"
	win_money.text = "$" 
	rolls_remaining.text =  "$"
	money_made = 0
	cash_out_btn.disabled = true

func _on_cash_out_pressed() -> void:
	update_money()
	reset_labels()
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")
	
