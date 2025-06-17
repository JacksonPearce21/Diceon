extends Node2D
var money_made = 0

@onready var win_money = $"Pop-up/Win_money"
@onready var rolls_remaining = $"Pop-up/Rolls_left"
@onready var interest_label = $"Pop-up/Interest"
@onready var cash_out_btn = $"Pop-up/cash_out"

func _ready():
	cash_out_btn.disabled
	
	pass
	
func calculate_money():
	cash_out_btn.text =  "Cash Out $" + str(money_made)
	

func update_money():
	GlobalManager.money += money_made
	update_labels()
	
func update_labels():
	rolls_remaining.text =  "$" + str(GlobalManager.dice_rolls)
	
	cash_out_btn.text =  "Cash Out $" + str(money_made)
	
	GlobalManager.calc_interest()
	interest_label.text =  "$" + str(GlobalManager.interest)
	
	
	calculate_money()
	
func reset_labels():
	cash_out_btn.text =  "Cash Out $0"
	GlobalManager.interest = 0
	interest_label.text =  "$0" 
	rolls_remaining.text =  "$0" 
	
	
	


func _on_cash_out_pressed() -> void:
	hide()
	reset_labels()
	
